<p align="center">
<img src="https://github.com/vektorious/lightm/blob/master/img/lightM_logo_v1.png" width="300"/>
<h1 align="center">Taking a closer look on how microbes move!</h1>
<h3 align="center">Deep analysis tools and low-cost hardware setup for microbe motility determination</h3>
</p>
<!---

<img src="https://badges.frapsoft.com/os/v1/open-source.png?v=103"/>
[![Generic badge](https://img.shields.io/badge/Open Science-Hardware-blue.svg)](http://openhardware.science/)
-->

## Hello!
Welcome to the lightM project repository! It started under the name [MBac](https://github.com/vektorious/mbac) as part of Mozilla Open Leaders Round 5 in early 2018. In the end of 2018 at the [Gathering for Open Science Hardware](http://openhardware.science/) we decided to change the name to lightM to reflect that the usage is not restricted just to bacteria. Here we work on the development of software tools and a low-cost open hardware setup to study how bacteria move. If you are interested you can read a bit more about the idea behind lightM in this README and get in contact on [gitter](https://gitter.im/lightM-chat/Lobby).
<p align="center">
:star::star2: <a href="https://github.com/vektorious/lightM/issues">Things we are currently working on</a> :star2::star:
</p>
You can directly jump to the sections:

- [How everything started](#what-are-your-bacteria-doing-when-you-are-not-looking)
- [A bit of background](#why-would-somebody-be-interested-in-bacteria-movements)
- [What's to solve?](#let-me-present-to-you-the-problem)
- [How can you contribute?](#how-can-you-contribute)
- [And why should you contribute?](#and-why-should-you-contribute)
- [Who is behind all this?](#who-is-behind-all-this)



## What are your microbes doing when you are not looking?
<img align="right" width="300" height="300" src="https://github.com/vektorious/lightM/blob/master/img/mot_example.png">

I am working with bacteria and some time ago I started to perform experiments to see how well my favorite bacteria can move. For this I usually put some of the bacteria in the middle of an agar plate in the evening, kept them at their favorite temperature for the night and was greeted in the morning with shapes like you can see on the right.

Pretty amazing, right? Sometimes they reminded me of [fractals](https://en.wikipedia.org/wiki/Fractal) but they can also be very plain. I was instantly curious about what the bacteria are doing in the night when I am not watching and how these shapes form. That's when I started imaging the agar plates with a Raspberry Pi + camera and created time lapse videos ([like this](https://youtu.be/TahGsuiCjec)) from them. From there the idea emerged to use the pictures to calculate the area the bacteria cover and the movement rate to see how they change over time!

In October 2018 I met [Fernand](https://federicilab.org/) and his research group at [GOSH 2018](http://openhardware.science/) and we decided to collaborate on this project. They are mainly interested in imaging the growth of fungi to help classifying them.

## Why would somebody be interested in microbes movements?
Almost all bacteria can perform some kind of active movement. This means they can travel distances with their own power without being transported by wind or water. The ability to move is very crucial because it makes a lot of things easier and faster. For example bacteria can follow traces of small molecules which lead them to their food (this is called [chemotaxis](https://en.wikipedia.org/wiki/Chemotaxis)). You can imagine this like the smell of a freshly brewed coffee which you follow to find its source (the cup of coffee you might be craving for). And like you the bacteria rely on active movement to reach favourite food! Another advantage is the resulting ability to move to different places to check out how living is there. This enables the bacteria start new communities and discover food sources. They can also move together as a group like a swarm of fish in the sea or birds in the sky (that's why this ability is called [swarming motility](https://en.wikipedia.org/wiki/Swarming_motility)).

While all this very useful for the bacteria it often causes problems when we try to fight harmful bacteria species. For example some species can quickly form community layer ([biofilm](https://en.wikipedia.org/wiki/Biofilm)) on medical instruments which are hard to remove because the bacteria provide each other stability and protection. That's why the ability to move and spread faster sometimes makes a bacterium more dangerous  than others. This is one reason why many scientists are studying bacteria movements and how they are made possible. In my PhD project I am looking at molecular surface structures of bacteria and how they influence the way bacteria move and colonize plants

## Let me present to you: The Problem
<img align="right" width="300" height="300" src="https://github.com/vektorious/mbac/blob/master/img/pretest.gif">

Analyzing bacteria movements is sometimes tedious. Experiments with the same bacteria often produce very different results because the movements are depending on many different things. Thats's why a standardized hardware setup could help to avoid influences from outside and contribute to always get similar results if you repeat an experiment. It's similar with fungi on agar plates. There are plenty possibilities to monitor their growth and spread on agar plates but using a standardized setup and analysis could improve the result quality.

Using computer vision software to monitor microbe movements and spreading increases the accuracy because you don't have just one data point but hundreds. Additionally one could analyze the shapes which are formed by the moving microbes and maybe discover some new things which influence them!

On the right you can see a gif of my first pre tests with bacteria. As you can see the shapes change during the time and I would have missed that without taking all those pictures!
## How can you contribute?

<p align="center">
<img src="https://github.com/vektorious/mbac/blob/master/img/setup_sketch_v1.png" width="900"/>

Above you see the proposed setup.  

The project can be divided into two parts:

[Hardware](#) :hammer:

Design a setup for "dark field" agar plate imaging with a Raspberry Pi + camera. You could contribute by:
- designing/optimizing the imaging setup
- testing the setup
- create a Raspberry Pi image server

[Software](#) :dvd:

Write a computer vision application to calculate the area the microbes cover and how fast they spread from images. You could contribute by helping us to develop a script which can:
- identify agar plates on a picture
- detect microbe spreading on agar plates
- calculate the area covered by the microbes

For a more detailed description about how you can contribute check out [CONTRIBUTING.md](https://github.com/vektorious/mbac/blob/master/CONTRIBUTING.md) or join our [gitter channel](https://gitter.im/lightM-chat/Lobby).

Since this project was part of Mozilla Open Leaders Round 5 (and because they are well elaborated) the [Mozilla Community Participation Guidelines](https://www.mozilla.org/en-US/about/governance/policies/participation/) apply to everyone who wants to contribute to this project.

## And why should you contribute?

If you like to try something new or you want to train your 3D design and coding skills this project is perfect for you! You can play around with computer vision and at the same time solve a scientific problem. Additionally you will learn a bit about microbes and how microbiologist characterize them.

And ultimately we might be able to publish the results in a peer-reviewed scientific journal (which is open access of course!) or at least at a the preprint server [BioRxiv](https://www.biorxiv.org/) and you will be listed as co-author!

## Who is behind all this?
I am a PhD student at the Technical University of Munich, combining microbiology, plant sciences and biochemistry in my research. I love 3D printing, recreating scientific instruments and getting lost on unnecessary nerdy projects. lightM (formerly MBac)started as one of such nerdy projects but turned into something unexpectedly useful. If you want to know about other things I do and have done so far you can visit [my personal website](http://alexanderkutschera.me/) or follow me on [twitter](https://twitter.com/alexwastooshort).
