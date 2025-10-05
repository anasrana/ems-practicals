---
title: "Essentials of Mathematics and Statistics"
author: "Anas A Rana"
date: "2025-10-05"
site: bookdown::bookdown_site

bibliography:
- book.bib
- packages.bib
description: |
  This is a resource containing the practical session for Essentials of Mathematics and Statistics part of your MSc Bioinformatics course.
biblio-style: apalike
csl: "chicago-fullnote-bibliography.csl"
---

```{=html}
<script>
// Theme switcher functionality for EMS Practicals
(function() {
  'use strict';

  // Theme switching function
  function toggleTheme() {
    const currentTheme = document.documentElement.getAttribute('data-theme');
    const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
    
    document.documentElement.setAttribute('data-theme', newTheme);
    localStorage.setItem('theme', newTheme);
    
    // Update button icon
    updateThemeButton(newTheme);
  }

  // Update theme button appearance
  function updateThemeButton(theme) {
    const button = document.getElementById('theme-toggle');
    if (button) {
      const lightIcon = button.querySelector('.light-icon');
      const darkIcon = button.querySelector('.dark-icon');
      
      if (theme === 'dark') {
        lightIcon.style.display = 'none';
        darkIcon.style.display = 'inline';
        button.setAttribute('aria-label', 'Switch to light mode');
      } else {
        lightIcon.style.display = 'inline';
        darkIcon.style.display = 'none';
        button.setAttribute('aria-label', 'Switch to dark mode');
      }
    }
  }

  // Initialize theme
  function initTheme() {
    // Check for saved theme, otherwise check system preference
    let savedTheme = localStorage.getItem('theme');
    
    if (!savedTheme) {
      // Check system preference
      if (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
        savedTheme = 'dark';
      } else {
        savedTheme = 'light';
      }
    }
    
    document.documentElement.setAttribute('data-theme', savedTheme);
    updateThemeButton(savedTheme);
  }

  // Create theme toggle button
  function createThemeButton() {
    const button = document.createElement('button');
    button.id = 'theme-toggle';
    button.className = 'theme-toggle-btn';
    button.innerHTML = `
      <span class="light-icon">🌙</span>
      <span class="dark-icon">☀️</span>
    `;
    button.onclick = toggleTheme;
    button.setAttribute('aria-label', 'Toggle theme');
    
    // Try to find the best place to insert the button
    const navbar = document.querySelector('.navbar');
    const sidebar = document.querySelector('.bs4-sidebar');
    const header = document.querySelector('header');
    
    if (navbar) {
      navbar.appendChild(button);
    } else if (sidebar) {
      sidebar.insertBefore(button, sidebar.firstChild);
    } else if (header) {
      header.appendChild(button);
    } else {
      // Fallback: add to body
      document.body.appendChild(button);
    }
  }

  // Listen for system theme changes
  function listenForSystemThemeChanges() {
    if (window.matchMedia) {
      const mediaQuery = window.matchMedia('(prefers-color-scheme: dark)');
      mediaQuery.addListener(function(e) {
        // Only auto-switch if user hasn't manually set a preference
        if (!localStorage.getItem('theme')) {
          const newTheme = e.matches ? 'dark' : 'light';
          document.documentElement.setAttribute('data-theme', newTheme);
          updateThemeButton(newTheme);
        }
      });
    }
  }

  // Initialize when DOM is ready
  function init() {
    initTheme();
    
    // Wait for DOM to be fully loaded
    if (document.readyState === 'loading') {
      document.addEventListener('DOMContentLoaded', function() {
        createThemeButton();
        listenForSystemThemeChanges();
      });
    } else {
      createThemeButton();
      listenForSystemThemeChanges();
    }
  }

  // Start initialization
  init();

})();
</script>
```

# Introduction to the Practical {-}

On this website you will find the resources for the practical session for the module Essentials of Mathematics and Statistics (EMS) part of the MSc Bioinformatics course at the University of Birmingham.

## What is this module about? {-}

The module covers the basics of mathematics and statistics that you will need to understand the rest of the modules in the course. It is important to have a good understanding of these concepts as they will be used in the other modules. This resource is designed to help you understand the concepts covered in the module by applying them to real and simulated data. It is an essential part of your learning and will help you to understand the concepts better.

## What will you learn? {-}

The topics covered in this practical include:

- Sampling a random variable
- Probability in R
- Simulating Markov Chains
- Monte Carlo Simulation
- Hypothesis Testing
- Linear regression
- Principal Component Analysis (PCA)
- Multivariate Regression
- Generalised Linear Models

## How to use these resources {-}

There are some basic concepts that you should be familiar with before starting this practical. If you are not familiar with these concepts, you should review them before starting the practical. You can find the resources for these concepts in the [Introduction to R](#start) section.

You will find information about accessing data for the practical sessions in the [Data](#data-sets) section.

The practical sessions are divided into sections, each covering a different topic. Broadly these fall into two categories the first part covers probability in `R` and the second part covers Statistical Modelling.
You can navigate between the sections using the links in the navigation bar. Each section contains a brief introduction to the topic, followed by a series of exercises. You should complete the exercises in order, following the lectures that introduce the concepts.

You should ensure you attend the practical sessions to get the most out of this resource. The practical sessions will provide you with the opportunity to ask questions, get help with the exercises, and go into more details.

Each session will contain a number of exercises that you should complete before moving on to the next session. You can check your answers by comparing them to the solutions provided in the resource.
