// Import and register all your controllers from the importmap under controllers/*

import { application } from "controllers/application"

// Eager load all controllers defined in the import map under controllers/**/*_controller
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)

document.addEventListener('DOMContentLoaded', function() {
  const viewMoreBtn = document.getElementById('view-more-btn');
  const viewLessBtn = document.getElementById('view-less-btn');
  const comments = document.querySelectorAll('#comments .comment');

  if (viewMoreBtn) {
    viewMoreBtn.addEventListener('click', function() {
      comments.forEach((comment, index) => {
        if (index >= 5) {
          comment.classList.remove('hidden');
        }
      });
      viewMoreBtn.style.display = 'none';
      viewLessBtn.style.display = 'inline';
    });
  }

  if (viewLessBtn) {
    viewLessBtn.addEventListener('click', function() {
      comments.forEach((comment, index) => {
        if (index >= 5) {
          comment.classList.add('hidden');
        }
      });
      viewMoreBtn.style.display = 'inline';
      viewLessBtn.style.display = 'none';
    });
  }
});
