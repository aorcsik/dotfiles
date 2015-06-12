#!/bin/sh

ec2dns() {
    AWSTOOL=`which aws`
    if [ -z "`echo $AWSTOOL | grep '/aws'`" ]; then
        echo "[\033[0;31mError\033[0m] Missing AWS tool, install it from: http://timkay.com/aws/" >&2
        return 3
    fi
    if [ -z "`cat $AWSTOOL | grep "timkay.com/aws"`" ]; then
        echo "[\033[0;31mError\033[0m] Something is wrong with $AWSTOOL, install it from: http://timkay.com/aws/" >&2
        return 4
    fi

    INSTANCE_ID=`echo $1 | grep "[0-9a-f]\{8\}" | sed -e "s:^.*\([0-9a-f]\{8\}\)$:i-\\1:"`
    if [ -z "$INSTANCE_ID" ]; then
        echo "[\033[0;31mError\033[0m] Invalid instance ID '$1'" >&2
        return 1
    fi

    echo "[info] Searching for instance ID '$INSTANCE_ID' in region 'us-east-1'..." >&2
    RESULT=`$AWSTOOL --cmd0 --xml describe-instances $INSTANCE_ID --region "us-east-1"`
    if [ -n "`echo $RESULT | grep '<Error>'`" ]; then
        echo "[info] Searching for instance ID '$INSTANCE_ID' in region 'us-west-2'..." >&2
        RESULT=`$AWSTOOL --cmd0 --xml describe-instances $INSTANCE_ID --region "us-west-2"`
    fi
    if [ -n "`echo $RESULT | grep '<Error>'`" ]; then
        MESSAGE=`echo $RESULT | grep '<Message>' | sed -E "s:^.*<Message>(.+)</Message>.*$:\\1:g"`
        echo "[\033[0;31mError\033[0m] $MESSAGE" >&2
        return 2
    fi

    echo $RESULT | grep dnsName | sed -E "s:^.*<dnsName>(.+)</dnsName>.*$:\\1:g"
}

ec2ssh() {
    DNS=`ec2dns $1`
    if [ -z "$DNS" ]; then
        return 1
    fi
    echo "[info] Connecting to $DNS..." >&2
    ssh -lroot $DNS $2
}

ec2chef() {
    ec2ssh $1 'chef-shell -z'
}
