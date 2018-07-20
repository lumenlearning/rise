---
title: 'RISE: An R package for RISE analysis'
tags:
  - R
  - learning analytics
  - open educational resources
  - continuous improvement
authors:
  - name: David Wiley
    orcid: 0000-0001-6722-4744
    affiliation: "1, 2" # (Multiple affiliations must be quoted)
affiliations:
 - name: Lumen Learning
   index: 1
 - name: Brigham Young University
   index: 2
date: 20 July 2018
bibliography: paper.bib
---

# Summary

Learning analytics provide designers of educational materials with the
ability to ask and answer questions about the effectiveness of those
materials in supporting student learning. However, copyright typically
prevents designers from engaging in continuous improvement activities. 
Open educational resources provide designers of educational materials 
with copyright permission to revise and remix those materials, but
they do not provide insights into where designers might most 
productively invest their continuous improvement efforts. Combining 
learning analytics with open educational resources opens the door to 
data-driven continuous improvement of educational materials. 
However, no open source tools exist to support designers in this 
time-intensive process.

``rise`` is an R package that implements the resource inspection,
selection, and evaluation (RISE) technique described in [@Bodily:2017].
``rise`` combines information about course learning outcomes, student
use of learning materials aligned with learning outcomes, and student
performance on assessments aligned with learning outcomes in order to
automatically identify places where learning materials are not 
effectively supporting student learning. Automating the process of 
identifying areas for improvement allows designers to spend less of 
their time determining which learning materials need to be improved 
and more time actually making improvements to learning materials.

The source code for ``rise`` has been archived to Zenodo with the 
linked DOI: [@zenodo]

# Acknowledgements

I gratefully acknowledge contributions to the model implemented in
``rise`` made by my co-authors of the original paper, Bob Bodily and
Rob Nyland.

# References