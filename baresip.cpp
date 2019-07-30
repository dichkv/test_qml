#include "baresip_inc.h"

static void signal_handler(int sig)
{
    static bool term = false;

    if (term) {
        mod_close();
        exit(0);
    }

    term = true;

    info("terminated by signal %d\n", sig);

    ua_stop_all(false);
}

static void ua_exit_handler(void *arg)
{
    (void)arg;
    debug("ua exited -- stopping main runloop\n");

    /* The main run-loop can be stopped now */
    re_cancel();
}

static void mqueue_handler(int id, void *data, void *arg)
{
    struct baresip_t *bs = static_cast<struct baresip_t *> (arg);
    const char *uri;
    struct call *call;
    int err = 0;
    struct ua *ua = uag_current();

    switch ( static_cast <enum baresip_events> (id) ) {

    case MQ_POPUP: /*
        gdk_threads_enter();
        popup_menu(mod, NULL, NULL, 0, GPOINTER_TO_UINT(data));
        gdk_threads_leave(); */
        break;

    case MQ_CONNECT:
        uri = static_cast<char *> (data);
        printf("Dial to %s\n", uri);
        err = ua_connect(ua, &call, nullptr, uri, VIDMODE_ON);
        if (err) {
            break;
        }

        bs->curr_call = call;

        if (err) {
            ua_hangup(ua, call, 500, "Server Error");
        }
        break;

    case MQ_HANGUP:
        call = static_cast<struct call *> (data);
        printf("Hangup call\n");
        ua_hangup(ua, call, 0, nullptr);
        break;

    case MQ_QUIT:
        ua_stop_all(false);
        break;

    case MQ_ANSWER:
        call = bs->curr_call;
        err = ua_answer(ua, call);
        if (err) {
            break;
        }

        if (err) {
            ua_hangup(ua, call, 500, "Server Error");
        }
        break;

    case MQ_SELECT_UA:
        ua = static_cast<struct ua *> (data);
        uag_current_set(ua);
        break;
    }
}

static const char *ua_event_reg_str(enum ua_event ev)
{
    switch (ev) {

    case UA_EVENT_REGISTERING:      return "registering";
    case UA_EVENT_REGISTER_OK:      return "OK";
    case UA_EVENT_REGISTER_FAIL:    return "ERR";
    case UA_EVENT_UNREGISTERING:    return "unregistering";
    default: return "?";
    }
}

static void ua_event_handler(struct ua *ua,
                 enum ua_event ev,
                 struct call *call,
                 const char *prm,
                 void *arg)
{
    //struct gtk3 *gtk = (struct gtk3 *) arg;
    (void)prm;
    (void)ua;

    switch (ev) {

    case UA_EVENT_REGISTERING:
    case UA_EVENT_UNREGISTERING:
    case UA_EVENT_REGISTER_OK:
    case UA_EVENT_REGISTER_FAIL:
        info("Account register status %s\n", ua_event_reg_str(ev));
        break;

    case UA_EVENT_CALL_INCOMING:
        info("Incoming call\n");
        (static_cast<struct baresip_t *>(arg))->curr_call = call;
        break;

    case UA_EVENT_CALL_CLOSED:
        info("Call close\n");
        break;

    case UA_EVENT_CALL_RINGING:
        info("Call ringing\n");
        break;

    case UA_EVENT_CALL_PROGRESS:
        info("Call progress\n");
        break;

    case UA_EVENT_CALL_ESTABLISHED:
        info("Call established\n");
        break;

    case UA_EVENT_CALL_TRANSFER_FAILED:
        info("Call transfer failed\n");
        break;

    default:
        break;
    }
}

int baresip::initialize_display(void)
{
    int err;

    this->bsip = static_cast <struct baresip_t *> (malloc(sizeof(struct baresip_t *)));
    err = mqueue_alloc(&this->bsip->mq, mqueue_handler, this->bsip);
    uag_event_register(ua_event_handler, this->bsip);

    return err;
}

void baresip::run()
{
    int err;

    setbuf(stdout, nullptr);

    err = libre_init();
    if (err)
        goto out;

    err = conf_configure();
    if (err) {
        warning("main: configure failed: %m\n", err);
        goto out;
    }

    err = baresip_init(conf_config());
    if (err) {
        warning("main: baresip init failed (%m)\n", err);
        goto out;
    }

    /* Set audio path preferring the one given in -p argument (if any) */
    if (str_isset(conf_config()->audio.audio_path)) {
        play_set_path(baresip_player(), conf_config()->audio.audio_path);
    } else {
        qInfo() << "Can't find audio path in config file\n";
    }

    /* Initialise User Agents */
    err = ua_init("baresip v" BARESIP_VERSION " (" ARCH "/" OS ")", true, true, true);
    if (err)
        goto out;

    uag_set_exit_handler(ua_exit_handler, nullptr);

    /* Load modules */
    err = conf_modules();
    if (err)
        goto out;

    this->bsip = new (struct baresip_t);

    err = mqueue_alloc(&this->bsip->mq, mqueue_handler, this->bsip);
    uag_event_register(ua_event_handler, this->bsip);

    /* Main loop */
    err = re_main(signal_handler);

out:

    mem_deref(this->bsip->mq);
    delete this->bsip;

    if (err)
        ua_stop_all(true);

    ua_close();

    /* note: must be done before mod_close() */
    module_app_unload();

    conf_close();

    baresip_close();

    /* NOTE: modules must be unloaded after all application
     *       activity has stopped.
     */
    debug("main: unloading modules..\n");
    mod_close();

    libre_close();

    return;
}
