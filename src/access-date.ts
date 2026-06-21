const MONTH_YEAR_FORMATTER = new Intl.DateTimeFormat('pt-BR', {
  month: 'long',
  year: 'numeric',
});

export function renderAccessMonthYear(): void {
  const label = MONTH_YEAR_FORMATTER.format(new Date());
  document.querySelectorAll('[data-access-month-year]').forEach((el) => {
    el.textContent = label;
  });
}
