# Created by: Daniel Solsona <daniel@ish.com.au>, Guido Falsi <madpilot@FreeBSD.org>
# $FreeBSD$

PORTNAME=	logstash
PORTVERSION=	1.2.1
CATEGORIES=	sysutils java
MASTER_SITES=	https://logstash.objects.dreamhost.com/release/ \
		https://download.elasticsearch.org/logstash/logstash/
DISTNAME=	${PORTNAME}-${PORTVERSION}-flatjar
EXTRACT_SUFX=	.jar
EXTRACT_ONLY=

MAINTAINER=	regis.despres@gmail.com
COMMENT=	Tool for managing events and logs

USE_JAVA=	yes
JAVA_VERSION=	1.6+

NO_BUILD=	yes

USE_RC_SUBR=	logstash

LOGSTASH_HOME?=	${PREFIX}/${PORTNAME}
LOGSTASH_HOME_REL?=	${LOGSTASH_HOME:S,^${PREFIX}/,,}
LOGSTASH_JAR?=	${DISTNAME}${EXTRACT_SUFX}
LOGSTASH_RUN?=	/var/run/${PORTNAME}
LOGSTASH_DATA_DIR?=	/var/db/${PORTNAME}

SUB_LIST=	LOGSTASH_DATA_DIR=${LOGSTASH_DATA_DIR} JAVA_HOME=${JAVA_HOME} \
		LOGSTASH_HOME=${LOGSTASH_HOME} LOGSTASH_JAR=${LOGSTASH_JAR}
PLIST_SUB+=	LOGSTASH_HOME=${LOGSTASH_HOME_REL} LOGSTASH_JAR=${LOGSTASH_JAR} \
		LOGSTASH_RUN=${LOGSTASH_RUN} \
		LOGSTASH_DATA_DIR=${LOGSTASH_DATA_DIR}

do-install:
	${MKDIR} ${STAGEDIR}${ETCDIR}
	${MKDIR} ${STAGEDIR}${LOGSTASH_HOME}
	${INSTALL_DATA} ${DISTDIR}/${DIST_SUBDIR}/${LOGSTASH_JAR} ${STAGEDIR}${LOGSTASH_HOME}
	${INSTALL_DATA} ${FILESDIR}/logstash.conf.sample ${STAGEDIR}${ETCDIR}
	${INSTALL_DATA} ${FILESDIR}/elasticsearch.yml.sample ${STAGEDIR}${ETCDIR}

.include <bsd.port.mk>
