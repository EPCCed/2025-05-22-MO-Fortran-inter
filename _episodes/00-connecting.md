---
title: "Connecting to ARCHER2 and transferring data"
teaching: 20
exercises: 20
questions:
- "What can I expect from this course?"
- "How will the course work and how will I get help?"
- "How can I give feedback to improve the course?"
- "How can I access ARCHER2 interactively?"
objectives:
- "Understand how this course works, how I can get help and how I can give feedback."
- "Understand how to connect to ARCHER2."
keypoints:
- "We should all understand and follow the [ARCHER2 Code of Conduct][archer2-tcoc] to ensure this course is conducted in the best teaching environment."
- "The course will be flexible to best meet the learning needs of the attendees."
- "Feedback is an essential part of our training to allow us to continue to improve and make sure the course is as useful as possible to attendees."
- "ARCHER2's login address is `login.archer2.ac.uk`."
- "You have to change the default text password the first time you log in"
- "MFA is mandatory in ARCHER2"
---

## Purpose

Attendees of this course will get access to the ARCHER2 HPC facility.
You will have the ability to request an account and to login to ARCHER2 before the course begins.
If you are not able to login, you can come to this pre-session where the instructors will help make sure you can login to ARCHER2.

Note that if you are not able to login to ARCHER2, and do not attend this session,
you may struggle to run the course exercises as these were designed to run on ARCHER2 specifically.

## Connecting using SSH

The ARCHER2 login address is

```bash
login.archer2.ac.uk
```

Access to ARCHER2 is via SSH using **both** a time-based one time password (TOTP) and a passphrase-protected SSH key pair.

## Passwords and password policy

When you first get an ARCHER2 account, you will get a single-use password from the SAFE which you will be asked to change to a password of your choice.
Your chosen  password must have the required complexity as specified in the [ARCHER2 Password Policy][archer2-password].

The password policy has been chosen to allow users to use both complex, shorter passwords and long, but comparatively simple passwords.
For example, passwords in the style of both `LA10!£lsty` and `horsebatterystaple` would be supported.

## SSH keys

As well as password access, users are required to add the public part of an SSH key pair to access ARCHER2. The public part of the key pair is associated with your account using the SAFE web interface.
See the ARCHER2 User and Best Practice Guide for information on how to create SSH key pairs and associate them with your account:

* [Connecting to ARCHER2][archer2-connecting].

## TOTP/MFA

ARCHER2 accounts are now required to use timed one-time passwords (TOTP), as part of a multi-factor authorisation (MFA) system.
Instructions on how to add MFA authentication to a machine account on SAFE can be found [here][safe-machine-mfa].

## Data transfer services: scp, rsync, Globus Online

ARCHER2 supports a number of different data transfer mechanisms.
The one you choose depends on the amount and structure of the data you want to transfer and where you want to transfer the data to.
The three main options are:

* `scp`: The standard way to transfer small to medium amounts of data off ARCHER2 to any other location.
* `rsync`: Used if you need to keep small to medium datasets synchronised between two different locations

More information on data transfer mechanisms can be found in the ARCHER2 User and Best Practice Guide:

* [Data management and transfer][archer2-data].

## Installation

For details of how to log into an ARCHER2 account, see https://docs.archer2.ac.uk/quick-start/quickstart-users/

Check out the git repository to your laptop or ARCHER2 account.
```
$ git clone https://github.com/EPCCed/2025-05-19-MO-Fortran-intro.git
$ cd 2025-05-19-MO-Fortran-intro
```
The default Fortran compiler on ARCHER2 is the Cray Fortran compiler
invoked using `ftn`. For example,
```
$ cd section1.01
$ ftn example1.f90
```
should generate an executable with the default name `a.out`.

Each section of the course is associated with a different directory,
each of which
contains a number of example programs and exercise templates. Answers to
exercises generally re-appear as templates to later exercises.
Miscellaneous solutions also appear in the [solutions](./solutions) directory.

Not all the examples compile. Some have deliberate errors which will be
discussed as part of the course.

## Course structure and method

Rather than having separate lectures and practical sessions, this course is taught following [The Carpentries methodology][c-site],
where we all work together through material learning key skills and information throughout the course.
Typically, this follows the method of the instructor demonstrating and then the attendees doing along with the instructor.

There are many helpers available to assist you and to answer any questions you may have as we work through the material together.
You should also feel free to ask questions of the instructor whenever you like.
The instructor will also provide many opportunities to pause and ask questions.

We will also make use of a shared collaborative document - the *etherpad*.
You will find a link to this collaborative document on the course page.
We will use it for a number of different purposes, for example,
it may be used during exercises and instructors and helpers may put useful information,
or links in the etherpad that help or expand on the material being taught.
If you have useful information to share with the class then please do add it to the etherpad.
At the end of the course, we take a copy of the information in the etherpad,
remove any personally-identifiable information,
and post this on the course archive page so you should always be able to come back and find any information you found useful.

## Feedback

Feedback is integral to how we approach training both during and after the course.
In particular, we use informal and structured feedback activities during the course to ensure we tailor the pace and content appropriately for the attendees,
and feedback after the course to help us improve our training for the future.

If you are not comfortable with the pace/content then you can use the reaction function of the collaborate session.

At the lunch break (and end of days for multi-day courses) we will also run a quick feedback activity to gauge how the course is matching onto attendees requirements.
Instructors and helpers will review this feedback over lunch and provide a summary of what we found at the start of the next session and, potentially, how the upcoming materiel/schedule will be changed to address the feedback.

Finally, you will be provided with the opportunity to provide feedback on the course after it has finished.
We welcome all this feedback, both good and bad, as this information in key to allow us to continually improve the training we offer.

{% include links.md %}
