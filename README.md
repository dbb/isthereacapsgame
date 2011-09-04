# Is there a Caps game?

## What's it all about?

Simple: you want to know if there's a Washington Capitals game, so you visit this app. It tells you.

## What a great idea!

Yup, I only wish it were mine. I took this idea wholesale from Mark Paschal and his [Is there a Giants game?](http://isthereagiantsga.me/)

## Tell us how to use the app, please

No problem. If you visit [the site](http://isthereacapsga.me/), you get an answer to the $64,000 question, "Is there a Caps game today?" If you want to know about other days, that's easy too. Visit `/tomorrow` to find out if there's a game tomorrow. (You can also check today more explicitly at `/today`).

If you want to get fancier, you can check whether there's a game on a specific day of the current week. Just enter visit `/dayname`. Note that this check always looks *forward*. So if it's Friday, and you check `/friday`, the app will check if there's a game *next* Friday.

Finally, you can get even fancier and see if there's a game on a specific date. Just enter the date you want to check in YYYYMMDD format. Example `/20110920`.

## I can haz API?

Yes, soon, I promise. It will be a simple JSON response, so it shouldn't take very long.


## License?

tl;dr MIT license. Do what you like with it.

See LICENSE for details.

## How do I complain or make a suggestion?

Post an [issue](https://github.com/telemachus/isthereacapsgame/issues). If you don't have a Github account and you're a geek, you should get one. If you're a Caps fan and not a geek, just let me know [on Twitter](https://twitter.com/#!/telemachus).
