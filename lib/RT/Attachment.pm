# BEGIN LICENSE BLOCK
# 
# Copyright (c) 1996-2002 Jesse Vincent <jesse@bestpractical.com>
# 
# (Except where explictly superceded by other copyright notices)
# 
# This work is made available to you under the terms of Version 2 of
# the GNU General Public License. A copy of that license should have
# been provided with this software, but in any event can be snarfed
# from www.gnu.org
# 
# This work is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
# 
# 
# Unless otherwise specified, all modifications, corrections or
# extensions to this work which alter its source code become the
# property of Best Practical Solutions, LLC when submitted for
# inclusion in the work.
# 
# 
# END LICENSE BLOCK
# Autogenerated by DBIx::SearchBuilder factory (by <jesse@bestpractical.com>)
# WARNING: THIS FILE IS AUTOGENERATED. ALL CHANGES TO THIS FILE WILL BE LOST.  
# 
# !! DO NOT EDIT THIS FILE !!
#

use strict;


=head1 NAME

RT::Attachment


=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHODS

=cut

package RT::Attachment;
use RT::Record; 


use vars qw( @ISA );
@ISA= qw( RT::Record );

sub _Init {
  my $self = shift; 

  $self->Table('Attachments');
  $self->SUPER::_Init(@_);
}





=item Create PARAMHASH

Create takes a hash of values and creates a row in the database:

  int(11) 'TransactionId'.
  int(11) 'Parent'.
  varchar(160) 'MessageId'.
  varchar(255) 'Subject'.
  varchar(255) 'Filename'.
  varchar(80) 'ContentType'.
  varchar(80) 'ContentEncoding'.
  longtext 'Content'.
  longtext 'Headers'.

=cut




sub Create {
    my $self = shift;
    my %args = ( 
                TransactionId => '0',
                Parent => '',
                MessageId => '',
                Subject => '',
                Filename => '',
                ContentType => '',
                ContentEncoding => '',
                Content => '',
                Headers => '',

		  @_);
    $self->SUPER::Create(
                         TransactionId => $args{'TransactionId'},
                         Parent => $args{'Parent'},
                         MessageId => $args{'MessageId'},
                         Subject => $args{'Subject'},
                         Filename => $args{'Filename'},
                         ContentType => $args{'ContentType'},
                         ContentEncoding => $args{'ContentEncoding'},
                         Content => $args{'Content'},
                         Headers => $args{'Headers'},
);

}



=item id

Returns the current value of id. 
(In the database, id is stored as int(11).)


=cut


=item TransactionId

Returns the current value of TransactionId. 
(In the database, TransactionId is stored as int(11).)



=item SetTransactionId VALUE


Set TransactionId to VALUE. 
Returns (1, 'Status message') on success and (0, 'Error Message') on failure.
(In the database, TransactionId will be stored as a int(11).)


=cut


=item Parent

Returns the current value of Parent. 
(In the database, Parent is stored as int(11).)



=item SetParent VALUE


Set Parent to VALUE. 
Returns (1, 'Status message') on success and (0, 'Error Message') on failure.
(In the database, Parent will be stored as a int(11).)


=cut


=item MessageId

Returns the current value of MessageId. 
(In the database, MessageId is stored as varchar(160).)



=item SetMessageId VALUE


Set MessageId to VALUE. 
Returns (1, 'Status message') on success and (0, 'Error Message') on failure.
(In the database, MessageId will be stored as a varchar(160).)


=cut


=item Subject

Returns the current value of Subject. 
(In the database, Subject is stored as varchar(255).)



=item SetSubject VALUE


Set Subject to VALUE. 
Returns (1, 'Status message') on success and (0, 'Error Message') on failure.
(In the database, Subject will be stored as a varchar(255).)


=cut


=item Filename

Returns the current value of Filename. 
(In the database, Filename is stored as varchar(255).)



=item SetFilename VALUE


Set Filename to VALUE. 
Returns (1, 'Status message') on success and (0, 'Error Message') on failure.
(In the database, Filename will be stored as a varchar(255).)


=cut


=item ContentType

Returns the current value of ContentType. 
(In the database, ContentType is stored as varchar(80).)



=item SetContentType VALUE


Set ContentType to VALUE. 
Returns (1, 'Status message') on success and (0, 'Error Message') on failure.
(In the database, ContentType will be stored as a varchar(80).)


=cut


=item ContentEncoding

Returns the current value of ContentEncoding. 
(In the database, ContentEncoding is stored as varchar(80).)



=item SetContentEncoding VALUE


Set ContentEncoding to VALUE. 
Returns (1, 'Status message') on success and (0, 'Error Message') on failure.
(In the database, ContentEncoding will be stored as a varchar(80).)


=cut


=item Content

Returns the current value of Content. 
(In the database, Content is stored as longtext.)



=item SetContent VALUE


Set Content to VALUE. 
Returns (1, 'Status message') on success and (0, 'Error Message') on failure.
(In the database, Content will be stored as a longtext.)


=cut


=item Headers

Returns the current value of Headers. 
(In the database, Headers is stored as longtext.)



=item SetHeaders VALUE


Set Headers to VALUE. 
Returns (1, 'Status message') on success and (0, 'Error Message') on failure.
(In the database, Headers will be stored as a longtext.)


=cut


=item Creator

Returns the current value of Creator. 
(In the database, Creator is stored as int(11).)


=cut


=item Created

Returns the current value of Created. 
(In the database, Created is stored as datetime.)


=cut



sub _ClassAccessible {
    {
     
        id =>
		{read => 1, type => 'int(11)', default => ''},
        TransactionId => 
		{read => 1, write => 1, type => 'int(11)', default => '0'},
        Parent => 
		{read => 1, write => 1, type => 'int(11)', default => ''},
        MessageId => 
		{read => 1, write => 1, type => 'varchar(160)', default => ''},
        Subject => 
		{read => 1, write => 1, type => 'varchar(255)', default => ''},
        Filename => 
		{read => 1, write => 1, type => 'varchar(255)', default => ''},
        ContentType => 
		{read => 1, write => 1, type => 'varchar(80)', default => ''},
        ContentEncoding => 
		{read => 1, write => 1, type => 'varchar(80)', default => ''},
        Content => 
		{read => 1, write => 1, type => 'longtext', default => ''},
        Headers => 
		{read => 1, write => 1, type => 'longtext', default => ''},
        Creator => 
		{read => 1, auto => 1, type => 'int(11)', default => ''},
        Created => 
		{read => 1, auto => 1, type => 'datetime', default => ''},

 }
};


        eval "require RT::Attachment_Overlay";
        if ($@ && $@ !~ /^Can't locate/) {
            die $@;
        };

        eval "require RT::Attachment_Local";
        if ($@ && $@ !~ /^Can't locate/) {
            die $@;
        };




=head1 SEE ALSO

This class allows "overlay" methods to be placed
into the following files _Overlay is for a System overlay by the original author,
while _Local is for site-local customizations.  

These overlay files can contain new subs or subs to replace existing subs in this module.

If you'll be working with perl 5.6.0 or greater, each of these files should begin with the line 

   no warnings qw(redefine);

so that perl does not kick and scream when you redefine a subroutine or variable in your overlay.

RT::Attachment_Overlay, RT::Attachment_Local

=cut


1;
