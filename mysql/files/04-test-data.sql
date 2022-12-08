INSERT INTO nas VALUES (NULL , '10.10.10.1', 'nas client name', 'other', NULL , 'passwordnas', NULL , NULL , 'RADIUS Client nas1');
INSERT INTO radcheck VALUES (NULL , 'user1', 'Cleartext-Password', ':=', 'passworduser1');
INSERT INTO radreply VALUES (NULL , 'user1', 'Framed-IP-Address', ':=', '10.10.10.2');
