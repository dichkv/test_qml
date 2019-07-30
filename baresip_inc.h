#include <stdint.h>
#include <stdlib.h>
#include <re/re.h>
#include <baresip.h>

#include <QThread>
#include <QtCore>

enum baresip_events {
    MQ_POPUP,
    MQ_CONNECT,
    MQ_QUIT,
    MQ_ANSWER,
    MQ_HANGUP,
    MQ_SELECT_UA,
};

struct baresip_t {
    struct call *curr_call;
    struct mqueue *mq;
};

class baresip : public QThread
{
    Q_OBJECT
    void run() override;

public:
    QChar dial[16];
    struct baresip_t *bsip;

    int initialize_display(void);

signals:
    void resultReady(const QString &s);
    //void ua_event_registations(enum ua_event ev);
    //void ua_event_call_status(struct baresip_t *bs);
};
