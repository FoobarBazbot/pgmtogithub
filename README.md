pgmtogithub
===========
A silly little script that forges a bunch of git timestamps to stuff an image in the graph of commit history on your main user page.

See comments for usage. Note that the intended use is to push something _before_ your real commits to real projects, but you can also use an image with high maxval to write in the same time period as the genuine commits, overwhelming them by sheer volume.

If you're writing something before real commits, make sure your pgm's maxval is about the same as your maximum commits/day -- too low, and your image will be faded, too high, and your actual commits will suffer decreased resolution.

Also note that you will probably want to put any such stuff in a blank repository, so you can easily remove/replace it later.
