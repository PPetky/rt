
package RT;

=head1 NAME

RT::Config

=for testing
use RT::Config;

=cut

# {{{ Base Configuration

# $rtname the string that RT will look for in mail messages to
# figure out what ticket a new piece of mail belongs to

# Your domain name is recommended, so as not to pollute the namespace.
# once you start using a given tag, you should probably never change it. 
# (otherwise, mail for existing tickets won't get put in the right place

$rtname="example.com";  

# You should set this to your organization's DNS domain. For example,
# fsck.com or asylum.arkham.ma.us. It's used by the linking interface to 
# guarantee that ticket URIs are unique and easy to construct.

$Organization = "example.com";

# $user_passwd_min defines the minimum length for user passwords. Setting
# it to 0 disables this check
$MinimumPasswordLength = "5";

# $Timezone is used to convert times entered by users into GMT and back again
# It should be set to a timezone recognized by your local unix box.
$Timezone =  'US/Eastern'; 

$BasePath = '/opt/rt3';

$EtcPath = '/opt/rt3/etc';
$VarPath = '/opt/rt3/var';
$LocalLexiconPath = '@RT_LOCAL_PO_PATH@';


# This directory should be writable by your rt group
$LogDir = '@RT_LOG_DIR@';


# $MasonComponentRoot is where your rt instance keeps its mason html files
# (this should be autoconfigured during 'make install' or 'make upgrade')

$MasonComponentRoot = '/opt/rt3/html';

# $MasonLocalComponentRoot is where your rt instance keeps its site-local
# mason html files.
# (this should be autoconfigured during 'make install' or 'make upgrade')

$MasonLocalComponentRoot = '/opt/rt3/local/html';

# $MasonDataDir Where mason keeps its datafiles
# (this should be autoconfigured during 'make install' or 'make upgrade')

$MasonDataDir = '/opt/rt3/var/mason_data';

# RT needs to put session data (for preserving state between connections
# via the web interface)
$MasonSessionDir = '/opt/rt3/var/session_data';

# }}}


# }}}

# {{{ Database Configuration

# Database driver beeing used. Case matters
# Valid types are "mysql" and "Pg" 

#$DatabaseType="SQLite";
$DatabaseType="mysql";
#$DatabaseType="Pg";

# The domain name of your database server
# If you're running mysql and it's on localhost,
# leave it blank for enhanced performance
$DatabaseHost="";
$DatabaseRTHost="localhost";

# The port that your database server is running on.  Ignored unless it's 
# a positive integer. It's usually safe to leave this blank
$DatabasePort="";


#The name of the database user (inside the database) 
$DatabaseUser='rt_user';

# Password the DatabaseUser should use to access the database
$DatabasePassword='rt_pass';


# The name of the RT's database on your database server
$DatabaseName='rt3';

# If you're using Postgres and have compiled in SSL support, 
# set DatabaseRequireSSL to 1 to turn on SSL communication
$DatabaseRequireSSL=undef;

# }}}

# {{{ Incoming mail gateway configuration


# OwnerEmail is the address of a human who manages RT. RT will send
# errors generated by the mail gateway to this address.  This address
# should _not_ be an address that's managed by your RT instance.

$OwnerEmail = 'root';

# If $LoopsToRTOwner is defined, RT will send mail that it believes 
# might be a loop to $RT::OwnerEmail 

$LoopsToRTOwner = 1;

# If $StoreLoopss is defined, RT will record messages that it believes 
# to be part of mail loops.
# As it does this, it will try to be careful not to send mail to the 
# sender of these messages 

$StoreLoops = undef;


# $MaxAttachmentSize sets the maximum size (in bytes) of attachments stored
# in the database. 

# For mysql and oracle, we set this size at 10 megabytes.
# If you're running a postgres version earlier than 7.1, you will need
# to drop this to 8192. (8k)

$MaxAttachmentSize = 10000000;  

# $TruncateLongAttachments: if this is set to a non-undef value,
# RT will truncate attachments longer than MaxAttachmentLength. 

$TruncateLongAttachments = undef;


# $DropLongAttachments: if this is set to a non-undef value,
# RT will silently drop attachments longer than MaxAttachmentLength. 

$DropLongAttachments = undef;

# If $ParseNewMessageForTicketCcs is true, RT will attempt to divine
# Ticket 'Cc' watchers from the To and Cc lines of incoming messages
# Be forewarned that if you have _any_ addresses which forward mail to
# RT automatically and you enable this option without modifying 
# "RTAddressRegexp" below, you will get yourself into a heap of trouble.

$ParseNewMessageForTicketCcs = undef;

# RTAddressRegexp is used to make sure RT doesn't add itself as a ticket CC if
# the setting above is enabled.

$RTAddressRegexp = '^rt\@example.com$';


# RT provides functionality which allows the system to rewrite
# incoming email addresses.  In its simplest form,
# you can substitute the value in CanonicalizeEmailAddressReplace
# for the value in CanonicalizeEmailAddressMatch
# (These values are passed to the CanonicalizeEmailAddress subroutine in RT/User.pm)
# By default, that routine performs a s/$Match/$Replace/gi on any address passed to it

$CanonicalizeEmailAddressMatch = 'subdomain.example.com$';
$CanonicalizeEmailAddressReplace = 'example.com';


# If $SenderMustExistInExternalDatabase is true, RT will refuse to
# create non-privileged accounts for unknown users if you are using 
# the "LookupSenderInExternalDatabase" option.
# Instead, an error message will be mailed and RT will forward the 
# message to $RTOwner.
#
# If you are not using $LookupSenderInExternalDatabase, this option
# has no effect.
#
# If you define an AutoRejectRequest template, RT will use this   
# template for the rejection message.

$SenderMustExistInExternalDatabase = undef;


# }}}

# {{{ Outgoing mail configuration

#$MailAlias is a generic alias to send mail to for any request
#already in a queue.  

#RT is designed such that any mail which already has a ticket-id associated
#with it will get to the right place automatically.

#This is the default address that will be listed in 
#From: and Reply-To: headers of mail tracked by RT unless overridden
#by a queue specific address

$CorrespondAddress='RT::CorrespondAddress.not.set';

$CommentAddress='RT::CommentAddress.not.set';


#Sendmail Configuration

# $MailCommand defines which method RT will use to try to send mail
# We know that 'sendmail' works fairly well.
# If 'sendmail' doesn't work well for you, try 'sendmailpipe' 
# But note that you have to configure $SendmailPath and add a -t 
# to $SendmailArguments

$MailCommand = 'sendmail';

# $SendmailArguments defines what flags to pass to $Sendmail
# assuming you picked 'sendmail' or 'sendmailpipe' as the $MailCommand above.
# If you picked 'sendmailpipe', you MUST add a -t flag to $SendmailArguments

# These options are good for most sendmail wrappers and workalikes
$SendmailArguments="-oi";

# These arguments are good for sendmail brand sendmail 8 and newer
#$SendmailArguments="-oi -ODeliveryMode=b -OErrorMode=m";

# If you selected 'sendmailpipe' above, you MUST specify the path
# to your sendmail binary in $SendmailPath.  
# !! If you did not # select 'sendmailpipe' above, this has no effect!!
$SendmailPath = "/usr/sbin/sendmail";

# RT can optionally set a "Friendly" 'To:' header when sending messages to 
# Ccs or AdminCcs (rather than having a blank 'To:' header.
# This feature DOES NOT WORK WITH SENDMAIL[tm] BRAND SENDMAIL
# If you are using sendmail, rather than postfix, qmail, exim or some other MTA,
# you _must_ disable this option.

$UseFriendlyToLine = 1;


# }}}

# {{{ Logging

# Logging.  The default is to log anything except debugging
# information to a logfile.  Check the Log::Dispatch POD for
# information about how to get things by syslog, mail or anything
# else, get debugging info in the log, etc. 

#  It might generally make
# sense to send error and higher by email to some administrator. 
# If you do this, be careful that this email isn't sent to this RT instance.


# the minimum level error that will be logged to the specific device.
# levels from lowest to highest:  
#  debug info notice warning error critical alert emergency 


#  Mail loops will generate a critical log message.
$LogToSyslog = 'debug';
$LogToScreen = 'debug';
$LogToFile = undef;
$LogToFileNamed = "$LogDir/rt.log"; #log to rt.log.<pid>.<user>

# }}}

# {{{ Web interface configuration



# Define the directory name to be used for images in rt web
# documents.

# If you're putting the web ui somewhere other than at the root of
# your server
# $WebPath requires a leading / but no trailing /     

$WebPath = "";

# This is the Scheme, server and port for constructing urls to webrt
# $WebBaseURL doesn't need a trailing /                                                                            

$WebBaseURL = "http://RT::WebBaseURL.not.configured:80";

$WebURL = $WebBaseURL . $WebPath . "/";



# $WebImagesURL points to the base URL where RT can find its images.
# If you're running the FastCGI version of the RT web interface,
# you should make RT's WebRT/html/NoAuth/images directory available on 
# a static web server and supply that URL as $WebImagesURL.

$WebImagesURL = $WebURL."/NoAuth/images/";

# $RTLogoURL points to the URL of the RT logo displayed in the web UI

$LogoURL = $WebImagesURL."/rt.jpg";

# If $WebExternalAuth is defined, RT will defer to the environment's
# REMOTE_USER variable.

$WebExternalAuth = undef;

# If $WebFallbackToInternalAuth is undefined, the user is allowed a chance
# of fallback to the login screen, even if REMOTE_USER failed.

$WebFallbackToInternalAuth = undef;

# $WebExternalGecos means to match 'gecos' field as the user identity;
# useful with mod_auth_pwcheck and IIS Integrated Windows logon.

$WebExternalGecos = undef;

# $WebExternalAuto will create users under the same name as REMOTE_USER
# upon login, if it's missing in the Users table.

$WebExternalAuto = undef;



#This is from tobias' prototype web search UI. it may stay and it may go.
%WebOptions=
    (
     # Here you can modify the list view.  Be aware that the web
     # interface might crash if TicketAttribute is wrongly set.
     
     QueueListingCols => 
      [
       { Header     => 'Id',				# loc
	 TicketLink => 1,
	 TicketAttribute => 'Id'
	 },

      { Header     => 'Subject',			# loc
	 TicketAttribute => 'Subject'
	 },
       { Header => 'Requestor(s)',			# loc
	 TicketAttribute => 'RequestorAddresses'
	 },
       { Header => 'Status',				# loc
	 TicketAttribute => 'CurrentUser->loc($Ticket->Status)'
	 },


       { Header => 'Queue',				# loc
	 TicketAttribute => 'QueueObj->Name'
	 },



       { Header => 'Told',				# loc
	 TicketAttribute => 'ToldObj->AgeAsString'
	 },  

       { Header => 'Age',				# loc
	 TicketAttribute => 'CreatedObj->AgeAsString'
	 },

       { Header => 'Last',				# loc
	 TicketAttribute => 'LastUpdatedObj->AgeAsString'
	 },

       # TODO: It would be nice with a link here to the Owner and all
       # other request owned by this Owner.
       { Header => 'Owner',				# loc
	 TicketAttribute => 'OwnerObj->Name'
       },
   
 
      ]
     );

# }}}

# {{{ RT UTF-8 Settings

# An array that contains default encodings used to guess which charset
# an attachment uses if not specified.  Must be recognized by
# Encode::Guess.

@EmailInputEncodings = (qw(utf-8 big5 gb2312));

# The charset for localized email.  Must be recognized by Encode.

$EmailOutputEncoding = 'utf-8';

# }}}

1;
