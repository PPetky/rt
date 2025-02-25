
# RT is an enterprise-grade issue tracking system.

RT allows organizations to keep track of what needs to get done, who is working on which tasks, what's already been done, and when tasks were (or weren't) completed.

RT doesn't cost anything to use, no matter how much you use it; it is freely available under the terms of Version 2 of the GNU General Public License.

RT is commercially-supported software. To purchase hosting, support, training, custom development, or professional services, please get in touch with us at <sales@bestpractical.com>.

![Screenshot of RT](docs/images/screenshot.png)

## REQUIRED PACKAGES

- Perl 5.10.1 or later ([http://www.perl.org](http://www.perl.org)).
    - RT won't start on versions of Perl older than 5.10.1.

- A supported SQL database
   - MySQL 5.7, 8 with InnoDB support
   - MariaDB 10.2 or later with InnoDB support
   - Postgres 9.5 or later
   - Oracle 12c or later
   - SQLite 3.0 or later (for testing only, no upgrade path guaranteed)

- A webserver with FastCGI or mod_perl support
    - Apache version 2.x ([https://httpd.apache.org](https://httpd.apache.org))
      - with mod_fcgid -- ([https://httpd.apache.org/mod_fcgid/mod/mod_fcgid.html](https://httpd.apache.org/mod_fcgid/mod/mod_fcgid.html))
      - or mod_perl -- ([http://perl.apache.org](http://perl.apache.org))
    - nginx -- ([https://nginx.org/](https://nginx.org/))
    - Another webserver with FastCGI support

    RT's FastCGI handler needs to access RT's configuration file.

- Various and sundry perl modules
    - A tool included with RT takes care of the installation of most of these automatically using Perl's CPAN ([http://www.cpan.org](http://www.cpan.org)). Some operating systems package all or some of the modules required, and you may be better off installing the modules that way.

## OPTIONAL DEPENDENCIES

- Full-text indexing support in your database
    - The databases listed above all have options for full-text indexing (excluding SQLite). See [docs/full_text_indexing.pod](https://docs.bestpractical.com/rt/latest/full_text_indexing.html) for details.
- An external HTML converter
    - Installing an external utility to convert HTML can improve performance. See the $HTMLFormatter configuration option for details.

- A TLS certificate for your web server
    - For production use, we recommend getting an SSL certificate for your web server. You can get them free from Let's Encrypt ([https://letsencrypt.org/](https://letsencrypt.org/)) or even create your own self-signed certificate.
    - If you are testing and want to run without a certificate, add this to your etc/RT_SiteConfig.pm file:
      ```
      Set( $WebSecureCookies, 0 );
      ```
    - Without this setting, your browser won't trust RT's cookies and you won't be able to log in. See
    [etc/RT_Config.html#WebSecureCookies](https://docs.bestpractical.com/rt/latest/RT_Config.html#WebSecureCookies) for more information.


## GENERAL INSTALLATION

1. **Unpack this distribution other than where you want to install RT.** Your home directory or `/usr/local/src` are both fine choices. Change to that directory and run the following command:
   ```
   tar xzvf rt.tar.gz
   ```

2. **Run the `configure` script.** To see the list of options, run:
   ```
   ./configure --help
   ```
   Peruse the options, then rerun `./configure` with the flags you want.

   RT defaults to installing in `/opt/rt5` with MySQL as its database. It
   tries to guess which of `www-data`, `www`, `apache` or `nobody` your
   webserver will run as, but you can override that behavior.  Note
   that the default install directory in `/opt/rt5` does not work under
   SELinux's default configuration.

   If you are upgrading from a previous version of RT, please review
   the upgrade notes for the appropriate versions, which can be found
   in `docs/UPGRADING-*`.

   If you are upgrading from 4.4.x to 5.0.x you should review both the [UPGRADING-4.4](https://docs.bestpractical.com/rt/latest/UPGRADING-4.4.html) and [UPGRADING-5.0](https://docs.bestpractical.com/rt/latest/UPGRADING-5.0.html) files.

   if you are upgrading from 4.2.x, you should review
   [UPGRADING-4.2](https://docs.bestpractical.com/rt/latest/UPGRADING-4.2.html) as well.

   Any upgrade steps given in version-specific `UPGRADING` files should
   be run after the rest of the steps below; however, please read the
   relevant documentation before beginning the upgrade, so as to be
   aware of important changes.

   RT stores the arguments given to `./configure` at the top of the
   `etc/RT_Config.pm` file in case you need to recreate your previous use
   of `./configure`.

3. Make sure that RT has the Perl and system libraries it needs to run.
   Check for missing dependencies by running:

   ```
   make testdeps
   ```

4. If the script reports any missing dependencies, install them by
   hand, or run the following command as a user who has permission to
   install perl modules on your system:
   ```
   make fixdeps
   ```

   Some modules require user input or environment variables to install
   correctly, so it may be necessary to install them manually. Some modules
   also require external source libraries, so you may need to install
   additional packages.

   If you are having trouble installing GD, refer to "Installing GD libraries"
   in [docs/charts.pod](https://docs.bestpractical.com/rt/latest/charts.html).
   Ticket relationship graphing requires the graphviz
   library which you should install using your distribution's package manager.

   See [docs/rt_perl.pod](https://docs.bestpractical.com/rt/latest/rt_perl.html)
   for additional information about installing perl and RT's dependencies.

5. Check to make sure everything was installed properly.
   ```
   make testdeps
   ```
   It might sometimes be necessary to run "make fixdeps" several times
   to install all necessary perl modules.

6a. If you are installing RT for the first time

   As a user with permission to install RT in your chosen directory, type:
   ```
   make install
   ```
   To configure RT with the web installer, run:
   ```
   /opt/rt5/sbin/rt-server
   ```
   and follow the instructions. Once completed, you should now have a
   working RT instance running with the standalone rt-server. Press
   Ctrl-C to stop it, and proceed to Step 7 to configure a recommended
   deployment environment for production.

   To configure RT manually, you must setup `etc/RT_SiteConfig.pm` in
   your RT installation directory. You'll need to add any values you
   need to change from the defaults in `etc/RT_Config.pm`.

   As a user with permission to read RT's configuration file, type:
   ```
   make initialize-database
   ```
   If the make fails, type:
   ```
   make dropdb
   ```

   and re-run `make initialize-database`.

6b. If you are upgrading from an older release of RT
   Before upgrading, always ensure that you have a complete current
   backup. If you don't have a current backup, upgrading your database
   could accidentally damage it and lose data, or worse.

   If you are using MySQL, please read the instructions in
   [docs/UPGRADING.mysql](https://docs.bestpractical.com/rt/latest/UPGRADING.mysql.html)
   as well to ensure that you do not corrupt existing data.

   - Stop your webserver.
   - You may also wish to put incoming email into a hold queue, to avoid temporary delivery failure messages if
   your upgrade is expected to take several hours.

   - Back up your database, as the next step may make changes to your database's schema and data.

   - Install new binaries, config files and libraries by running:
   ```
   make upgrade
   ```

   - This will also prompt you to upgrade your database by running:
   ```
   make upgrade-database
   ```

   When you run it, you will be prompted for your previous version of
   RT (such as 4.4.1) so that the appropriate set of database
   upgrades can be applied.

   If `make upgrade-database` completes without error, your upgrade
   has been successful; you should now run any commands that were
   supplied in version-specific UPGRADING documentation. You should
   then restart your webserver.

   Depending on the size and composition of your database, some upgrade
   steps may run for a long time. You may also need extra disk space or
   other resources while running upgrade steps. It's a good idea to run
   through the upgrade steps on a test server so you know what to expect
   before running on your production system.


7. Configure the web server, as described in [docs/web_deployment.pod](https://docs.bestpractical.com/rt/latest/web_deployment.html),
    and the email gateway, as described below.

    NOTE: The default credentials for RT are:
        - User: `root`
        - Pass: `password`
    *Not changing the root password from the default is a SECURITY risk!*

8. Set up users, groups, queues, scrips and access control.

    Until you do this, RT will not be able to send or receive email, nor
    will it be more than marginally functional.  This is not an optional
    step.

9. Set up automated recurring tasks (cronjobs):

    Depending on your configuration, RT stores sessions in the database
    or on the file system. In either case, sessions are only needed until
    a user logs out, so old sessions should be cleaned up with the
    [`sbin/rt-clean-sessions`](https://docs.bestpractical.com/rt/latest/rt-clean-sessions.html)` utility.

    To generate email digest messages, you must arrange for the provided
    utility to be run once daily, and once weekly. You may also want
    to arrange for the [`sbin/rt-email-dashboards`](https://docs.bestpractical.com/rt/latest/rt-email-dashboards.html) utility to be run hourly.

    RT automatically creates temporary short URLs for searches and these
    can be cleared from the system periodically as well. See the documentation
    for the [`sbin/rt-clean-shorteners`](https://docs.bestpractical.com/rt/latest/sbin/rt-clean-shorteners.html)
    tool for options. You can schedule this to run regularly if desired.

    If your task scheduler is cron, you can configure it by
    adding the following lines as `/etc/cron.d/rt`:

    ```
        0 0 * * * root /opt/rt5/sbin/rt-clean-sessions
        0 0 * * * root /opt/rt5/sbin/rt-email-digest -m daily
        0 0 * * 0 root /opt/rt5/sbin/rt-email-digest -m weekly
        0 * * * * root /opt/rt5/sbin/rt-email-dashboards
    ```

    Other optional features like full text search indexes, external
    attachments, etc., may also have recurring jobs to schedule in cron.
    Follow the documentation for these features when you enable them.

10. Configure the RT email gateway.  To let email flow to your RT
    server, you need to add a few lines of configuration to your mail
    server's "aliases" file. These lines "pipe" incoming email messages
    from your mail server to RT.

    Add the following lines to `/etc/aliases` (or your local equivalent)
    on your mail server:

    ```
    rt:         "|/opt/rt5/bin/rt-mailgate --queue general --action correspond --url http://rt.example.com"
    rt-comment: "|/opt/rt5/bin/rt-mailgate --queue general --action comment --url http://rt.example.com"
    ```

    You'll need to add similar lines for each queue you want to be able to
    send email to. To find out more about how to configure RT's email
    gateway, see [`bin/rt-mailgate`](https://docs.bestpractical.com/rt/latest/bin/rt-mailgate.html).

11. Set up full text search

    Full text search (FTS) without database indexing is a very slow operation,
    and is thus disabled by default. You'll need to follow the instructions in
    [docs/full_text_indexing.pod](https://docs.bestpractical.com/rt/latest/full_text_indexing.html) to enable FTS.

12. Set up automatic backups for RT and its data as described in
    [docs/system_administration/database.pod](https://docs.bestpractical.com/rt/latest/system_administration/database.html).

## GETTING HELP

If RT is mission-critical for you or if you use it heavily, we recommend
that you purchase a commercial support contract.  Details on support
contracts are available at [http://www.bestpractical.com](http://www.bestpractical.com) or by writing to
<sales@bestpractical.com>. We also offer managed hosting plans if you
prefer to have someone else manage the RT server.

If you're interested in having RT extended or customized or would like
more information about commercial support options, please send email to
<sales@bestpractical.com> to discuss rates and availability.


## COMMUNITY FORUM AND WIKI

To keep up to date on the latest RT tips, techniques and extensions, you
may wish to join the RT Community Forum website.  You can find it here:

[https://forum.bestpractical.com](https://forum.bestpractical.com)

You'll find many different categories of discussion there including the
RT Users category for general RT topics. If you're interested
in customizing RT code, there is a category for RT Developers with more
technical topics.

The RT wiki, at [https://rt-wiki.bestpractical.com](https://rt-wiki.bestpractical.com), is also an excellent
resource.


## SECURITY

If you believe you've discovered a security issue in RT, please send an
email to <security@bestpractical.com> with a detailed description of the
issue, and a secure means to respond to you (such as your PGP public
key).  You can find our PGP key and fingerprint at
[https://bestpractical.com/security/](https://bestpractical.com/security/)


## BUGS

RT's a pretty complex application, and as you get up to speed, you might
run into some trouble. Generally, it's best to ask about things you run
into on the Community Forum (or pick up a commercial support
contract from Best Practical). But, sometimes people do run into
bugs. In the exceedingly unlikely event that you hit a bug in RT, please
report it! We'd love to hear about problems you have with RT, so we can
fix them.  To report a bug, send email to <rt-bugs@bestpractical.com>.

Note that this sends email to our public RT instance. Do not include any
information in your email that you don't want shown publicly, including
contact information in your email signature.



# COPYRIGHT AND LICENSE

COPYRIGHT:

This software is Copyright (c) 1996-2023 Best Practical Solutions, LLC
                                         <sales@bestpractical.com>

(Except where explicitly superseded by other copyright notices)


LICENSE:

This work is made available to you under the terms of Version 2 of
the GNU General Public License. A copy of that license should have
been provided with this software, but in any event can be snarfed
from www.gnu.org.

This work is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
02110-1301 or visit their web page on the internet at
http://www.gnu.org/licenses/old-licenses/gpl-2.0.html.


CONTRIBUTION SUBMISSION POLICY:

(The following paragraph is not intended to limit the rights granted
to you to modify and distribute this software under the terms of
the GNU General Public License and is only of importance to you if
you choose to contribute your changes and enhancements to the
community by submitting them to Best Practical Solutions, LLC.)

By intentionally submitting any modifications, corrections or
derivatives to this work, or any other work intended for use with
Request Tracker, to Best Practical Solutions, LLC, you confirm that
you are the copyright holder for those contributions and you grant
Best Practical Solutions,  LLC a nonexclusive, worldwide, irrevocable,
royalty-free, perpetual, license to use, copy, create derivative
works based on those contributions, and sublicense and distribute
those contributions and any derivatives thereof.


#
