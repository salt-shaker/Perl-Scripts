<img src="https://i.ibb.co/C2Y9xps/0-CMft-Pj4-IUSw4p05d.png" alt="0-CMft-Pj4-IUSw4p05d" border="0">

# Perl-Scripts
A bunch of scripts from when I was learning Perl and Bash

<hr>

One of the first programming languages I started using was perl. The first was liberty basic, but that's another story. Perl is a high level, interpreted, general-purpose programming language. Perl is a great language to learn and is used by most operating systems for shell scripting. I was atracted to it because of its versatility and power. The fact that it was installed on unix and linux be default gave it a sense of out-of-the-box portablity that most programming langauges do not have. I learned a great deal about the fundamentals of programming by using perl but it lacked that super-star shimmer of Java Script and PHP so eventually I moved over to UX design.

Many of these scripts worked for what they were designed for. Quick and easy. They are provied as is, for learning. Use them at your own risk.

Also, this is a good read: <a href="https://blog.usejournal.com/what-is-perl-how-relevant-it-is-and-how-to-get-started-d802e7aba2cd">What is Perl? How relevant it is and how to get started!</a>

Below are some snippits from the internet showing that Perl Love.

<hr>

<p>FreeBSD is a great example of an OS using Perl. A few years ago they went through a lot of effort to remove Perl as a dependency for the base system. The base system is basically one giant source-code repo with the kernel, utilities, and everything. So they were maintaining their own fork of Perl in that repo, which was a big effort and hard to keep up-to-date with the upstream Perl. So it made sense for them to eliminate Perl from the base system and just install it as a port, which is much easier to keep up-to-date (because they're just fetching the upstream Perl releases and compiling them).</p>

<hr>

<i><h3>In Larry Wall's original Perl v1.0 posting to the comp.sources.misc newsgroup on December 18, 1987, he said:</h3></i>

If you have a problem that would ordinarily use sed or awk or sh, but it exceeds their capabilities or must run a little faster, and you don't want to write the silly thing in C, then perl may be for you.

<i><h3>In a much later exposition, he elaborated a little more:</h3></i>

But the frustrations of Unix shell programming led directly to the creation of Perl, which I don't really have time to tell. But essentially, I found that shell scripting was intrinsically limited by the fact that most of its verbs are not under its control and hence largely inconsistent with each other. And the nouns are impoverished, restricted to strings and files, with who-knows-what typology...

More destructive was the mindset that it was a one-dimensional universe: you either programmed in C or you programmed in shell, because they're obviously at opposite ends of the One True Continuum. Perl came about when I realized that scripting did not always have to viewed as the opposite of programming, but that a single language could be pretty good for both. That opened up a huge ecological niche. Many of you have seen my old clamshell diagram, with the two dimensions of manipulexity and whipuptitude.

Today, Perl is a standard alternative/replacement for shell-scripting and text parsing needs, and with much more power than the traditional tools. Because of it's extreme (some would say inelegant) flexibility, Perl has been described as "the Swiss Army chainsaw of scripting languages". Tasks can often be significantly shorter, easier, or more extensible when solved with Perl. Many, many system tools, scripts and larger programs are routinely written in Perl. So in the modern Linux environment, Perl is now another standard Unix tool, and truly indispensable.

<hr>

I think the answer to this question is in part historic, in part practical.

As for the history, Perl is a classy language. It is more classy than Python (not to mention PHP), although I have no idea what is "better" (if that could somehow be formally analyzed, which I doubt). And the classy guys who are using (or used) Perl are typically the guys deciding what should be part of a Linux distro.

As for what is practical, Perl is still the glue of a lot of things: OSs and the web alike (again, LAMP, not forgetting either Python or PHP). So why not include anything that is useful for a lot of purposes? And even more so, why remove anything that is there (and doesn't cause any harm), and is useful?

But, as it happens, there is a note on this in the most recent issue of The Linux Magazine (#151, June 2013). Apparently, in order to compile the Linux kernel a couple of short and simple Perl scripts are employed. (Again, the "glue" role of Perl in OSs.) Now, one of the kernel developers has been submitting patches of a re-write of those scripts, this time not in Perl, but as "Unix shell scripts" (is that sh?). That way, Perl would not have to be installed for anyone compiling the kernel. But, that patch (submitted several times) hasn't been picked up. And one reason for this is, once out in the cold, Perl is not likely to be let in. People like Perl, and they don't want to part with it.

Now, this only touches the fringes of this question as probably a very small minority of Linux users are likely to compile the kernel. But it is yet another piece of the puzzle (and I suspect there are many).

<hr>

Sources:</br>
https://en.wikipedia.org/wiki/Perl</br>
https://unix.stackexchange.com/questions/48018/why-is-perl-installed-by-default-with-most-linux-distributions</br>
