Sitemap Shareship
=================

Sharing
---------------

* Search -> searches#new
  * Results -> searches#show
    * Other Users Profile -> registration#show
      * Haus Übersicht -> houses#show
    * Article Pages as Visitor articles#show

* Inventar -> articles#index

* Templates -> articles#new_article_from_stockitems

Account Management
------

* Profile -> registration#edit
* Login -> session#new
  * Forgotten Password -> passwords#new
* Sign up -> registration#new

Emails
------

* (from Articles Pages as Visitor)
  * Article Requests -> user_mailer#article_request_mail
    * Article Pages as Owner articles#show
  * User Message -> user_mailer#user_message_mail
* (from Sign up)
  * Confirmation Instructions -> mailer#confirmation_instructions
    * Confirm Email Address -> confirmations#new
* (from Edit Password)
  * Password Change -> mailer#password_change
* (from Forgotten Password)
  * Reset Password Instructions -> mailer#reset_password_instructions
    * Edit Password -> passwords#edit
* (from Sign up)
  * Unlock Instructions -> mailer#unlock_instructions
    * Unlock Account -> unlocks#new

Documentation
-------------

* Rate (not linked from footer)
* Tutorial
* Guideline
* FAQ

Legal
-----

* Home
* Who is it
* Contact -> contacts#new
* Term
* Privacy
* Disclaimer
* About
* Contrib
