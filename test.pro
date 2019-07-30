QT += quick core
CONFIG += c++11

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        baresip.cpp \
        main.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    libc/libs/libbaresip.a \
    libc/libs/libbaresip.so \
    libc/libs/libre.a \
    libc/libs/libre.so \
    libc/libs/librem.a \
    libc/libs/librem.so

HEADERS += \
    baresip_inc.h \
    libc/include/baresip.h \
    libc/include/re/re.h \
    libc/include/re/re_aes.h \
    libc/include/re/re_base64.h \
    libc/include/re/re_bfcp.h \
    libc/include/re/re_bitv.h \
    libc/include/re/re_conf.h \
    libc/include/re/re_crc32.h \
    libc/include/re/re_dbg.h \
    libc/include/re/re_dns.h \
    libc/include/re/re_fmt.h \
    libc/include/re/re_hash.h \
    libc/include/re/re_hmac.h \
    libc/include/re/re_http.h \
    libc/include/re/re_httpauth.h \
    libc/include/re/re_ice.h \
    libc/include/re/re_jbuf.h \
    libc/include/re/re_json.h \
    libc/include/re/re_list.h \
    libc/include/re/re_lock.h \
    libc/include/re/re_main.h \
    libc/include/re/re_mbuf.h \
    libc/include/re/re_md5.h \
    libc/include/re/re_mem.h \
    libc/include/re/re_mod.h \
    libc/include/re/re_mqueue.h \
    libc/include/re/re_msg.h \
    libc/include/re/re_natbd.h \
    libc/include/re/re_net.h \
    libc/include/re/re_odict.h \
    libc/include/re/re_rtmp.h \
    libc/include/re/re_rtp.h \
    libc/include/re/re_sa.h \
    libc/include/re/re_sdp.h \
    libc/include/re/re_sha.h \
    libc/include/re/re_sip.h \
    libc/include/re/re_sipevent.h \
    libc/include/re/re_sipreg.h \
    libc/include/re/re_sipsess.h \
    libc/include/re/re_srtp.h \
    libc/include/re/re_stun.h \
    libc/include/re/re_sys.h \
    libc/include/re/re_tcp.h \
    libc/include/re/re_telev.h \
    libc/include/re/re_tls.h \
    libc/include/re/re_tmr.h \
    libc/include/re/re_turn.h \
    libc/include/re/re_types.h \
    libc/include/re/re_udp.h \
    libc/include/re/re_uri.h \
    libc/include/re/re_websock.h \
    libc/include/rem/rem.h \
    libc/include/rem/rem_aac.h \
    libc/include/rem/rem_au.h \
    libc/include/rem/rem_aubuf.h \
    libc/include/rem/rem_auconv.h \
    libc/include/rem/rem_audio.h \
    libc/include/rem/rem_aufile.h \
    libc/include/rem/rem_aumix.h \
    libc/include/rem/rem_auresamp.h \
    libc/include/rem/rem_autone.h \
    libc/include/rem/rem_avc.h \
    libc/include/rem/rem_dsp.h \
    libc/include/rem/rem_dtmf.h \
    libc/include/rem/rem_fir.h \
    libc/include/rem/rem_flv.h \
    libc/include/rem/rem_g711.h \
    libc/include/rem/rem_goertzel.h \
    libc/include/rem/rem_h264.h \
    libc/include/rem/rem_vid.h \
    libc/include/rem/rem_vidconv.h \
    libc/include/rem/rem_video.h \
    libc/include/rem/rem_vidmix.h

INCLUDEPATH += libc/include
LIBS += -Llibc/libs -lre -lrem -lbaresip
