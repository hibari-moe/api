#!/bin/sh
rm -rf "${0%/*}/sqlite3.db"
sqlite3 "${0%/*}/sqlite3.db" <<EOF
    create table contacts (id text, name text, age integer, data blob);

    insert into contacts (id, name, age, data) values ('1', 'John Doe', 30, X'53514C697465');
    insert into contacts (id, name, age, data) values ('2', 'Jane Doe', 32, X'6574694C5153');
EOF


#sqlite "${0%/*}/sqlite3.db" <<EOF
#    create table users (id text, slug text);
#    create table userStats (userID text, ) 
#EOF