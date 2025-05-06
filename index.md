---
layout: lesson
carpentry: "swc"
venue: "online"
address: 
country: "UK"
language: "English"
latlng: 
humandate: 
humantime: 
startdate: 
enddate: 
instructor: ["Paul Bartholomew and William Lucas"]
helper: [""]
email: [""]
collaborative_notes: 
eventbrite: 
root: .
---

<h2>Description</h2>

This course is aimed at users and developers who know how to program, but have little or no experience in Fortran, and those who may wish to have a refresher in Fortran.

Fortran (a contraction of Formula Translation) was the first programming language to have a standard (in 1954), but has changed significantly over the years. More recent standards (the latest being Fortran 2023) come under the umbrella term "Modern Fortran". Fortran retains very great significance in many areas of scientific and numerical computing, particularly for applications such as quantum chemistry, plasmas, and in numerical weather prediction and climate models.

This course provides an introduction to the basics of writing Fortran. It will cover basic syntax, variables, expressions and assignments, flow of control, and introductions to i/o and user-defined types. Common Fortran idioms are introduced and contrasted with those available in C-like languages; the course will try to focus on real usage rather than formal descriptions.

At the end of the course you should be able to understand many Fortran programs and be confident to start to write well-structured and portable Fortran. Fortran is a rather "large" language, so it is not possible to cover all its features in a two day course. Further elements of Fortran are discussed in the "Intermediate Modern Fortran" course.

Prerequisites: attendees must be familiar with the basic concepts of programming: variables, logic, flow of control, loops, functions and so on. No knowledge of Fortran is assumed. Previous programming experience might typically be in the context C/C++ or python. If you know no programming, we suggest this course on Fortran is not the place to start.

The course requires a Fortran compiler, for which a local machine or laptop may be appropriate [1]. If you do not have access to a Fortran compiler, course training accounts on ARCHER2 will be available which provide access to various compilers. Use of a text editor will be required (some may prefer an IDE, but we do not intend to consider or support IDEs).

[1] This may typically be gfortran, freely available as part of Gnu Compiler Collection (GCC). See e.g., https://gcc.gnu.org/wiki/GFortranBinaries

<hr/>

<h2 id="general">General Information</h2>

{% comment %}
  LOCATION

  This block displays the address and links to maps showing directions
  if the latitude and longitude of the workshop have been set.  You
  can use https://itouchmap.com/latlong.html to find the lat/long of an
  address.
{% endcomment %}
{% if page.latlng %}
<p id="where">
  <strong>Where:</strong>
  {{page.address}}.
  Get directions with
  <a href="//www.openstreetmap.org/?mlat={{page.latlng | replace:',','&mlon='}}&zoom=16">OpenStreetMap</a>
  or
  <a href="//maps.google.com/maps?q={{page.latlng}}">Google Maps</a>.
</p>
{% endif %}

{% comment %}
  DATE

  This block displays the date and links to Google Calendar.
{% endcomment %}
{% if page.humandate %}
<p id="when">
  <strong>When:</strong>
  {{page.humandate}}.
  {% include workshop_calendar.html %}
</p>
{% endif %}

{% comment %}
  SPECIAL REQUIREMENTS

  Modify the block below if there are any special requirements.
{% endcomment %}
<p id="requirements">
  <strong>Requirements:</strong> Participants must have a working laptop or 
  desktop computer with a Mac, Linux, or Windows operating system (not a 
  tablet, Chromebook, etc.) that they have administrative privileges on. They 
  should have access to a terminal (Max and Linux users should have a terminal 
  installed by default; Windows users should get either 
  <a href="https://mobaxterm.mobatek.net/">MobaXterm</a> or 
  <a href="https://www.putty.org/">PuTTY</a>. They are also required to abide 
  by the <a href="https://www.archer2.ac.uk/training/code-of-conduct/">ARCHER2 Training Code of Conduct</a>.
</p>

{% comment %}
  ACCESSIBILITY

  Modify the block below if there are any barriers to accessibility or
  special instructions.
{% endcomment %}
<p id="accessibility">
  <strong>Accessibility:</strong> We are committed to making this workshop
  accessible to everybody.
  
  Materials will be provided in advance of the lesson and
  large-print handouts are available if needed by notifying the
  organizers in advance.  If we can help making learning easier for
  you (e.g. sign-language interpreters, lactation facilities) please
  get in touch (using contact details below) and we will
  attempt to provide them.
</p>

{% comment %}
  CONTACT EMAIL ADDRESS

  Display the contact email address set in the configuration file.
{% endcomment %}
<p id="contact">
  <strong>Contact</strong>:
  Please email
  {% if page.email %}
    {% for email in page.email %}
      {% if forloop.last and page.email.size > 1 %}
        or
      {% else %}
        {% unless forloop.first %}
        ,
        {% endunless %}
      {% endif %}
      <a href='mailto:{{email}}'>{{email}}</a>
    {% endfor %}
  {% else %}
    to-be-announced
  {% endif %}
  for more information.
</p>

<hr/>

> ## Prerequisites
> You should have used remote HPC facilities before. In particular, you should be happy with connecting
> using SSH, know what a batch scheduling system is and be familiar with using the Linux command line.
> You should also be happy editing plain text files in a remote terminal (or, alternatively, editing them
> on your local system and copying them to the remote HPC system using `scp`).
{: .prereq}

<hr/>

{% include links.md %}

