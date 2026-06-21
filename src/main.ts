import '@features/mcp-architecture-viewer';
import '@shared/styles/global.css';
import { renderAccessMonthYear } from '@shared/lib/access-date';

renderAccessMonthYear();

if (typeof document$ !== 'undefined') {
  document$.subscribe(() => {
    renderAccessMonthYear();
  });
}
