import './components/docs-demo';
import './styles/global.css';

if (typeof document$ !== 'undefined') {
  document$.subscribe(() => {
    // Lit re-conecta automaticamente; hook reservado para componentes com canvas/WebGL.
  });
}
