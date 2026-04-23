document.addEventListener('DOMContentLoaded', () => {
  const popup = document.createElement('img');
  popup.className = 'icon-hover-popup';
  document.body.appendChild(popup);

  const GAP = 8;
  const SIZE = 80;

  const preloaded = {};
  document.querySelectorAll('.icon-link[data-hover-img]').forEach(link => {
    const src = link.dataset.hoverImg;
    const img = new Image();
    img.src = src;
    preloaded[src] = img;
  });

  document.querySelectorAll('.icon-link[data-hover-img]').forEach(link => {
    link.addEventListener('mouseenter', () => {
      popup.src = link.dataset.hoverImg;
      const rect = link.getBoundingClientRect();
      popup.style.left = `${rect.left + window.scrollX + rect.width / 2 - SIZE / 2}px`;
      popup.style.top = `${rect.top + window.scrollY - SIZE - GAP}px`;
      popup.classList.add('visible');
    });
    link.addEventListener('mouseleave', () => {
      popup.classList.remove('visible');
    });
  });
});
