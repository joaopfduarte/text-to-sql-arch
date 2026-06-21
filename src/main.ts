import './components/mcp-viewer';
import './styles/global.css';
import { renderAccessMonthYear } from './access-date';

renderAccessMonthYear();

if (typeof document$ !== 'undefined') {
  document$.subscribe(() => {
    renderAccessMonthYear();
  });
}
