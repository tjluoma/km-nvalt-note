[Justnotes][] received a bit of press attention this week, with links from [Ben Brooks][], [John Gruber][], and [MacStories][].

Ben describes his method of taking notes on his Mac like this:

> I just hit a Keyboard Maestro shortcut and a new note opens with the date filled as the name/title and then I jot down the name/number whatever I want to archive. I close the app. … Truly note taking on my Mac is minimal and mostly a transparent process.

He mentions that this doesn't work well with [nvALT][] because it (like Notational Velocity before it) has an "omnibar" which is used for both creating new notes and searching existing notes.

Ben likes Justnotes because it's easier to just create a note, but he left this detail until the end:

> Update: I forgot to mention that the way Justnotes names files is odd. It names them with what seems to be a random string when you use Dropbox — this will be really annoying if you go by notes names in iOS apps. So beware of that. Personally it doesn’t bug me because I just use search and notes previews in Notesy, but I can see how this is a deal breaker for some.

Randomized filenames are more than a little bit of a dealbreaker for me. I emailed the developer and he said that since so many people have complained about it, he's going to look for a solution. (I bought it anyway, against my usual advice to only buy an app if it works the way you want it to *now* vs *hopefully* working the way you want it to in the future. My excuse is that it is [currently on sale][].)

### Create a New Note in nvALT

I do agree with Ben that I wish nvALT had a "create new note" function, but since one wasn't forthcoming, I created my own.

The concept is pretty simple: pop up a panel in Keyboard Maestro with two fields: the first will become the filename, the second will become the file contents:

<img alt="[Keyboard Maestro input]" src="http://images.luo.ma/KeyboardMaestro_nvalt_input_1-20120520-212331.jpg" width="537" height="178" border="0" />

Of course, I couldn't *leave* it that simple, so I added a couple of improvements:

*	By default, the filename field will be filled in with the current date and time, in a format which can be used as a filename (meaning there are no / or : used). For example, right now if I created a file it would be named '2012-05-20_21.35.37'

*	I can set my own extension for the filename such as .txt or .md or anything else, but if I don't explicitly define one, ".txt" will be used.

* 	I will often copy something and then want to paste it into a note, so the default *content* of the note will be the current pasteboard/clipboard.

* 	*Sometimes* I might want to open the file in my default text editor after I create it

* 	*Sometimes* I might want to see the new note in nvALT after I create it

*	If I try to create a note with the same name as an existing note, the new text is *appended* to the existing file. If I come across a YouTube video I want to watch later, I use 'watchlater' for the filename. Apps that I want to checkout in the Mac App Store go in a 'mas' note. (If you use GTD-style "contexts" for your notes, such as "@work" or "@boss" you can easily append to those as well.)

I added two more buttons to the Keyboard Maestro prompt: one called "Show" which will show the note in nvALT after creating it, and another called "Open" which will open the file after creating it.

<img alt="[Keyboard Maestro input revised]" src="http://images.luo.ma/KeyboardMaestro-nvalt-2-20120520-214937.jpg" width="537" height="178" border="0" />

(Which app opens the file will depend on the file's extension and your Mac's settings. For example, I have .sh files set to open with [CodeRunner][], .md files set to open with [MultiMarkdown Composer ][], and other text files set to open with [BBEdit][].)

* I can create a note anywhere, without leaving the app I'm in.

* I get a Growl confirmation that the note was created

* nvALT doesn't even have to be open (and won't be launched unless needed)

* The input is immediately saved to a temp file in case anything goes wrong.


[BBEdit]: http://www.barebones.com/products/bbedit/
[MultiMarkdown Composer ]: http://itunes.apple.com/us/app/multimarkdown-composer/id473566589?mt=12
[CodeRunner]: http://itunes.apple.com/us/app/coderunner/id433335799?mt=12


### Setup and Configuration

Setup is fairly simple:

1. Import the Keyboard Maestro macro

2. Install a shell script somewhere in your $PATH

3. Edit the NVALT and DIRS variables in the shell script (unless you, like me, keep your nvALT files in `$HOME/Dropbox/txt`)

That's it. Once you've done those steps, press Control + Option + Command + N to create a new note.

*(You can change the keyboard shortcut from within Keyboard Maestro.)*

### p.s. The sad state of Simplenote

While I was once impressed with [Simplenote][], I am currently extremely dissatisfied. The performance of the web app is terrible. Syncing a large number of notes (1,000+) has never worked well, and there have been no noticeable improvements. The Export process can't deal with a large number of posts either, which meant that I had to jury-rig a solution.

The iOS apps have been extremely crash-prone lately, and every new version mentions crash fixes, and yet the app continues to crash so often that I now just expect that it will crash when I launch it.

The only thing which keeps me using it is the ability to create a new note via email, which I do frequently, but not enough to justify $20/year. (Especially when I could probably create my own mail-to-text service with a little bit of effort.)

I keep hoping that Simplenote will improve, but there has been little reason to maintain that hope.


[Simplenote]: https://simple-note.appspot.com/
[currently on sale]: http://itunes.apple.com/us/app/justnotes/id511230166?mt=12)
[nvALT]: http://brettterpstra.com/project/nvalt/
[MacStories]: http://www.MacStories.net/mac/justnotes-is-simplenotes-desktop-companion-and-a-little-more/
[John Gruber]: http://daringfireball.net/linked/2012/05/17/justnotes
[Ben Brooks]: http://brooksreview.net/2012/05/justnotes/
[Justnotes]: http://selfcoded.com/justnotes/
