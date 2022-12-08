# -*- text -*-
##
## setup.sql -- MySQL commands for creating the RADIUS user.
##
##	WARNING: You should change 'localhost' and 'radpass'
##		 to something else.  Also update raddb/mods-available/sql
##		 with the new RADIUS password.
##
##	$Id: 5ae98cc204a9b19573e75ba83183f0a2dc93757e $

#
#  Create default administrator for RADIUS
#
#CREATE USER 'radius'@'localhost' IDENTIFIED BY 'radpass';
#CREATE USER 'radius'@'172.16.0.0/256.240.0.0' IDENTIFIED BY 'radpass';
CREATE USER 'radius'@'%' IDENTIFIED BY 'radpass';

#
#  The server can read the authorisation data
#
GRANT SELECT ON radius.radcheck TO 'radius'@'%';
GRANT SELECT ON radius.radreply TO 'radius'@'%';
GRANT SELECT ON radius.radusergroup TO 'radius'@'%';
GRANT SELECT ON radius.radgroupcheck TO 'radius'@'%';
GRANT SELECT ON radius.radgroupreply TO 'radius'@'%';

#
#  The server can write accounting and post-auth data
#
GRANT SELECT, INSERT, UPDATE ON radius.radacct TO 'radius'@'%';
GRANT SELECT, INSERT, UPDATE ON radius.radpostauth TO 'radius'@'%';

#
#  The server can read the NAS data
#
GRANT SELECT ON radius.nas TO 'radius'@'%';

#
#  In the case of the "lightweight accounting-on/off" strategy, the server also
#  records NAS reload times
#
GRANT SELECT, INSERT, UPDATE ON radius.nasreload TO 'radius'@'%';
