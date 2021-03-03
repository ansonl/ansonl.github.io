---
published: false
---
## Microsoft Teams iOS Client 'Dodge Deauthentication & Make Voice Calls' Bug

**In short:** Microsoft Teams iOS client login screen can be bypassed after organization mandated login (refresh token) expiration has expired by dismissing the login view and tapping on the enabled user-interface elements. This behavior can be repeated an unlimited amount of times to browse section of the app and view protected data meant for a successfully authenticated user.
- Expiration example: _Organization mandates re-authentication period of 18 hours. The user is no longer authenticated 19 hours after initial login._
- Cached data such as notification, teams, and chat are available. 
- New Teams voice calls can be successfully joined with two way voice communication.

This behavior can be viewed in the iOS Microsoft Teams app on at least version 2.2.1. I have not tested this on the equivalent Android Teams app. Steps to access user data after your login expires are below:

1. Login to MS Teams account under an organization with a relogin (refresh token) expiration time of N. (Ex: Max lifetime of refresh token of 18 hours) MS Teams may be set to use a authentication method similar to [OAuth 2.0](https://www.digitalocean.com/community/tutorials/an-introduction-to-oauth-2).

2. Wait N hrs for the refresh token to expire. 

3. Open Teams iOS app. iOS client app will popup webview loading a login page at _https://login.microsoftonline.com/XXX/oauth2/v2.0/**authorize**_.
  - Before the login webview popup, the iOS client will find that the refresh_token is expired by a response from a request to _https://login.microsoftoline.com/XXX/oauth2/v2.0/**token**_.
  - See [OAuth 2.0](https://oauth.net/2/) for details on the _[Authorization Code](https://www.digitalocean.com/community/tutorials/an-introduction-to-oauth-2#grant-type-authorization-code)_ grant type login flow.

4. Click **"Cancel"** button in upper-left of the popup webview containing login page. The popup webview will dismiss by sliding down off the screen.

5. Full interaction and information viewing is possible in the iOS client app for a brief period. Examples of tested data access:
  - Bottom tab bar can be clicked to view different Teams data such as notifcations, chats, calendar.
  - Pull to refresh on notifications view will intiate a refresh and load new data
  - Clicking "join" meeting on calendar view will successfully join a team meeting and audio. (connection to _api.flightproxy.teams.microsoft.com_ made) Creation of the meeting is logged and can be seen in the "chat" view of an event showing who entered the meeting.

6. iOS client app may display a dialog indicating auth failure and an option to sign out. Click **"cancel"**. iOS client app will popup the login webview again.

7. Go to step 4. Repeated user privileged data access is possible by cancelling the popup login webview and tapping on parts of the graphical user interface during the few seconds before the login alert and webview pop up again. 

This login bypass and information disclosure vulnerability was submitted to [Microsoft Security Response Center (MSRC) Researcher Portal](https://msrc.microsoft.com/) and assigned case #63474. Screen recordings demonstrating bypass of the login screen and ability to successfully join a call were shared as well. 
A month later, Microsoft replied that this is expected behavior.

> We determined that this behavior is considered to be by design because after the tokens expire, the device still has cached data locally which is accessible to the Teams client.

A