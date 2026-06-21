import { createElement, type IconNode } from 'lucide';
import { Bot, Database, FolderTree, MessageSquare, Plug, ShieldCheck } from 'lucide';

const ICON_SIZE = 22;
const ICON_STROKE = 1.75;

export function lucideIconSvg(icon: IconNode, className = 'step-icon'): SVGElement {
  return createElement(icon, {
    width: ICON_SIZE,
    height: ICON_SIZE,
    stroke: 'currentColor',
    'stroke-width': ICON_STROKE,
    class: className,
    'aria-hidden': 'true',
  });
}

export const FLOW_ICONS = {
  query: MessageSquare,
  llm: Bot,
  mcp: Plug,
  atlas: FolderTree,
  validate: ShieldCheck,
  storage: Database,
} as const;

export type FlowIconId = keyof typeof FLOW_ICONS;
