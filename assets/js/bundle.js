(function(){"use strict";/**
 * @license
 * Copyright 2019 Google LLC
 * SPDX-License-Identifier: BSD-3-Clause
 */var vt;const U=globalThis,L=U.ShadowRoot&&(U.ShadyCSS===void 0||U.ShadyCSS.nativeShadow)&&"adoptedStyleSheets"in Document.prototype&&"replace"in CSSStyleSheet.prototype,j=Symbol(),Q=new WeakMap;let Y=class{constructor(t,e,i){if(this._$cssResult$=!0,i!==j)throw Error("CSSResult is not constructable. Use `unsafeCSS` or `css` instead.");this.cssText=t,this.t=e}get styleSheet(){let t=this.o;const e=this.t;if(L&&t===void 0){const i=e!==void 0&&e.length===1;i&&(t=Q.get(e)),t===void 0&&((this.o=t=new CSSStyleSheet).replaceSync(this.cssText),i&&Q.set(e,t))}return t}toString(){return this.cssText}};const X=r=>new Y(typeof r=="string"?r:r+"",void 0,j),tt=(r,...t)=>{const e=r.length===1?r[0]:t.reduce((i,s,o)=>i+(n=>{if(n._$cssResult$===!0)return n.cssText;if(typeof n=="number")return n;throw Error("Value passed to 'css' function must be a 'css' function result: "+n+". Use 'unsafeCSS' to pass non-literal values, but take care to ensure page security.")})(s)+r[o+1],r[0]);return new Y(e,r,j)},yt=(r,t)=>{if(L)r.adoptedStyleSheets=t.map(e=>e instanceof CSSStyleSheet?e:e.styleSheet);else for(const e of t){const i=document.createElement("style"),s=U.litNonce;s!==void 0&&i.setAttribute("nonce",s),i.textContent=e.cssText,r.appendChild(i)}},et=L?r=>r:r=>r instanceof CSSStyleSheet?(t=>{let e="";for(const i of t.cssRules)e+=i.cssText;return X(e)})(r):r;/**
 * @license
 * Copyright 2017 Google LLC
 * SPDX-License-Identifier: BSD-3-Clause
 */const{is:bt,defineProperty:At,getOwnPropertyDescriptor:xt,getOwnPropertyNames:wt,getOwnPropertySymbols:Et,getPrototypeOf:St}=Object,m=globalThis,it=m.trustedTypes,Ct=it?it.emptyScript:"",V=m.reactiveElementPolyfillSupport,w=(r,t)=>r,N={toAttribute(r,t){switch(t){case Boolean:r=r?Ct:null;break;case Object:case Array:r=r==null?r:JSON.stringify(r)}return r},fromAttribute(r,t){let e=r;switch(t){case Boolean:e=r!==null;break;case Number:e=r===null?null:Number(r);break;case Object:case Array:try{e=JSON.parse(r)}catch{e=null}}return e}},B=(r,t)=>!bt(r,t),st={attribute:!0,type:String,converter:N,reflect:!1,useDefault:!1,hasChanged:B};Symbol.metadata??(Symbol.metadata=Symbol("metadata")),m.litPropertyMetadata??(m.litPropertyMetadata=new WeakMap);let A=class extends HTMLElement{static addInitializer(t){this._$Ei(),(this.l??(this.l=[])).push(t)}static get observedAttributes(){return this.finalize(),this._$Eh&&[...this._$Eh.keys()]}static createProperty(t,e=st){if(e.state&&(e.attribute=!1),this._$Ei(),this.prototype.hasOwnProperty(t)&&((e=Object.create(e)).wrapped=!0),this.elementProperties.set(t,e),!e.noAccessor){const i=Symbol(),s=this.getPropertyDescriptor(t,i,e);s!==void 0&&At(this.prototype,t,s)}}static getPropertyDescriptor(t,e,i){const{get:s,set:o}=xt(this.prototype,t)??{get(){return this[e]},set(n){this[e]=n}};return{get:s,set(n){const c=s==null?void 0:s.call(this);o==null||o.call(this,n),this.requestUpdate(t,c,i)},configurable:!0,enumerable:!0}}static getPropertyOptions(t){return this.elementProperties.get(t)??st}static _$Ei(){if(this.hasOwnProperty(w("elementProperties")))return;const t=St(this);t.finalize(),t.l!==void 0&&(this.l=[...t.l]),this.elementProperties=new Map(t.elementProperties)}static finalize(){if(this.hasOwnProperty(w("finalized")))return;if(this.finalized=!0,this._$Ei(),this.hasOwnProperty(w("properties"))){const e=this.properties,i=[...wt(e),...Et(e)];for(const s of i)this.createProperty(s,e[s])}const t=this[Symbol.metadata];if(t!==null){const e=litPropertyMetadata.get(t);if(e!==void 0)for(const[i,s]of e)this.elementProperties.set(i,s)}this._$Eh=new Map;for(const[e,i]of this.elementProperties){const s=this._$Eu(e,i);s!==void 0&&this._$Eh.set(s,e)}this.elementStyles=this.finalizeStyles(this.styles)}static finalizeStyles(t){const e=[];if(Array.isArray(t)){const i=new Set(t.flat(1/0).reverse());for(const s of i)e.unshift(et(s))}else t!==void 0&&e.push(et(t));return e}static _$Eu(t,e){const i=e.attribute;return i===!1?void 0:typeof i=="string"?i:typeof t=="string"?t.toLowerCase():void 0}constructor(){super(),this._$Ep=void 0,this.isUpdatePending=!1,this.hasUpdated=!1,this._$Em=null,this._$Ev()}_$Ev(){var t;this._$ES=new Promise(e=>this.enableUpdating=e),this._$AL=new Map,this._$E_(),this.requestUpdate(),(t=this.constructor.l)==null||t.forEach(e=>e(this))}addController(t){var e;(this._$EO??(this._$EO=new Set)).add(t),this.renderRoot!==void 0&&this.isConnected&&((e=t.hostConnected)==null||e.call(t))}removeController(t){var e;(e=this._$EO)==null||e.delete(t)}_$E_(){const t=new Map,e=this.constructor.elementProperties;for(const i of e.keys())this.hasOwnProperty(i)&&(t.set(i,this[i]),delete this[i]);t.size>0&&(this._$Ep=t)}createRenderRoot(){const t=this.shadowRoot??this.attachShadow(this.constructor.shadowRootOptions);return yt(t,this.constructor.elementStyles),t}connectedCallback(){var t;this.renderRoot??(this.renderRoot=this.createRenderRoot()),this.enableUpdating(!0),(t=this._$EO)==null||t.forEach(e=>{var i;return(i=e.hostConnected)==null?void 0:i.call(e)})}enableUpdating(t){}disconnectedCallback(){var t;(t=this._$EO)==null||t.forEach(e=>{var i;return(i=e.hostDisconnected)==null?void 0:i.call(e)})}attributeChangedCallback(t,e,i){this._$AK(t,i)}_$ET(t,e){var o;const i=this.constructor.elementProperties.get(t),s=this.constructor._$Eu(t,i);if(s!==void 0&&i.reflect===!0){const n=(((o=i.converter)==null?void 0:o.toAttribute)!==void 0?i.converter:N).toAttribute(e,i.type);this._$Em=t,n==null?this.removeAttribute(s):this.setAttribute(s,n),this._$Em=null}}_$AK(t,e){var o,n;const i=this.constructor,s=i._$Eh.get(t);if(s!==void 0&&this._$Em!==s){const c=i.getPropertyOptions(s),a=typeof c.converter=="function"?{fromAttribute:c.converter}:((o=c.converter)==null?void 0:o.fromAttribute)!==void 0?c.converter:N;this._$Em=s;const l=a.fromAttribute(e,c.type);this[s]=l??((n=this._$Ej)==null?void 0:n.get(s))??l,this._$Em=null}}requestUpdate(t,e,i,s=!1,o){var n;if(t!==void 0){const c=this.constructor;if(s===!1&&(o=this[t]),i??(i=c.getPropertyOptions(t)),!((i.hasChanged??B)(o,e)||i.useDefault&&i.reflect&&o===((n=this._$Ej)==null?void 0:n.get(t))&&!this.hasAttribute(c._$Eu(t,i))))return;this.C(t,e,i)}this.isUpdatePending===!1&&(this._$ES=this._$EP())}C(t,e,{useDefault:i,reflect:s,wrapped:o},n){i&&!(this._$Ej??(this._$Ej=new Map)).has(t)&&(this._$Ej.set(t,n??e??this[t]),o!==!0||n!==void 0)||(this._$AL.has(t)||(this.hasUpdated||i||(e=void 0),this._$AL.set(t,e)),s===!0&&this._$Em!==t&&(this._$Eq??(this._$Eq=new Set)).add(t))}async _$EP(){this.isUpdatePending=!0;try{await this._$ES}catch(e){Promise.reject(e)}const t=this.scheduleUpdate();return t!=null&&await t,!this.isUpdatePending}scheduleUpdate(){return this.performUpdate()}performUpdate(){var i;if(!this.isUpdatePending)return;if(!this.hasUpdated){if(this.renderRoot??(this.renderRoot=this.createRenderRoot()),this._$Ep){for(const[o,n]of this._$Ep)this[o]=n;this._$Ep=void 0}const s=this.constructor.elementProperties;if(s.size>0)for(const[o,n]of s){const{wrapped:c}=n,a=this[o];c!==!0||this._$AL.has(o)||a===void 0||this.C(o,void 0,n,a)}}let t=!1;const e=this._$AL;try{t=this.shouldUpdate(e),t?(this.willUpdate(e),(i=this._$EO)==null||i.forEach(s=>{var o;return(o=s.hostUpdate)==null?void 0:o.call(s)}),this.update(e)):this._$EM()}catch(s){throw t=!1,this._$EM(),s}t&&this._$AE(e)}willUpdate(t){}_$AE(t){var e;(e=this._$EO)==null||e.forEach(i=>{var s;return(s=i.hostUpdated)==null?void 0:s.call(i)}),this.hasUpdated||(this.hasUpdated=!0,this.firstUpdated(t)),this.updated(t)}_$EM(){this._$AL=new Map,this.isUpdatePending=!1}get updateComplete(){return this.getUpdateComplete()}getUpdateComplete(){return this._$ES}shouldUpdate(t){return!0}update(t){this._$Eq&&(this._$Eq=this._$Eq.forEach(e=>this._$ET(e,this[e]))),this._$EM()}updated(t){}firstUpdated(t){}};A.elementStyles=[],A.shadowRootOptions={mode:"open"},A[w("elementProperties")]=new Map,A[w("finalized")]=new Map,V==null||V({ReactiveElement:A}),(m.reactiveElementVersions??(m.reactiveElementVersions=[])).push("2.1.2");/**
 * @license
 * Copyright 2017 Google LLC
 * SPDX-License-Identifier: BSD-3-Clause
 */const E=globalThis,rt=r=>r,R=E.trustedTypes,ot=R?R.createPolicy("lit-html",{createHTML:r=>r}):void 0,nt="$lit$",g=`lit$${Math.random().toFixed(9).slice(2)}$`,at="?"+g,Mt=`<${at}>`,$=document,S=()=>$.createComment(""),C=r=>r===null||typeof r!="object"&&typeof r!="function",q=Array.isArray,Pt=r=>q(r)||typeof(r==null?void 0:r[Symbol.iterator])=="function",W=`[ 	
\f\r]`,M=/<(?:(!--|\/[^a-zA-Z])|(\/?[a-zA-Z][^>\s]*)|(\/?$))/g,ct=/-->/g,dt=/>/g,_=RegExp(`>|${W}(?:([^\\s"'>=/]+)(${W}*=${W}*(?:[^ 	
\f\r"'\`<>=]|("|')|))|$)`,"g"),lt=/'/g,ht=/"/g,pt=/^(?:script|style|textarea|title)$/i,Ot=r=>(t,...e)=>({_$litType$:r,strings:t,values:e}),I=Ot(1),v=Symbol.for("lit-noChange"),h=Symbol.for("lit-nothing"),ut=new WeakMap,y=$.createTreeWalker($,129);function mt(r,t){if(!q(r)||!r.hasOwnProperty("raw"))throw Error("invalid template strings array");return ot!==void 0?ot.createHTML(t):t}const Tt=(r,t)=>{const e=r.length-1,i=[];let s,o=t===2?"<svg>":t===3?"<math>":"",n=M;for(let c=0;c<e;c++){const a=r[c];let l,p,d=-1,u=0;for(;u<a.length&&(n.lastIndex=u,p=n.exec(a),p!==null);)u=n.lastIndex,n===M?p[1]==="!--"?n=ct:p[1]!==void 0?n=dt:p[2]!==void 0?(pt.test(p[2])&&(s=RegExp("</"+p[2],"g")),n=_):p[3]!==void 0&&(n=_):n===_?p[0]===">"?(n=s??M,d=-1):p[1]===void 0?d=-2:(d=n.lastIndex-p[2].length,l=p[1],n=p[3]===void 0?_:p[3]==='"'?ht:lt):n===ht||n===lt?n=_:n===ct||n===dt?n=M:(n=_,s=void 0);const f=n===_&&r[c+1].startsWith("/>")?" ":"";o+=n===M?a+Mt:d>=0?(i.push(l),a.slice(0,d)+nt+a.slice(d)+g+f):a+g+(d===-2?c:f)}return[mt(r,o+(r[e]||"<?>")+(t===2?"</svg>":t===3?"</math>":"")),i]};class P{constructor({strings:t,_$litType$:e},i){let s;this.parts=[];let o=0,n=0;const c=t.length-1,a=this.parts,[l,p]=Tt(t,e);if(this.el=P.createElement(l,i),y.currentNode=this.el.content,e===2||e===3){const d=this.el.content.firstChild;d.replaceWith(...d.childNodes)}for(;(s=y.nextNode())!==null&&a.length<c;){if(s.nodeType===1){if(s.hasAttributes())for(const d of s.getAttributeNames())if(d.endsWith(nt)){const u=p[n++],f=s.getAttribute(d).split(g),D=/([.?@])?(.*)/.exec(u);a.push({type:1,index:o,name:D[2],strings:f,ctor:D[1]==="."?Ht:D[1]==="?"?Ut:D[1]==="@"?Nt:z}),s.removeAttribute(d)}else d.startsWith(g)&&(a.push({type:6,index:o}),s.removeAttribute(d));if(pt.test(s.tagName)){const d=s.textContent.split(g),u=d.length-1;if(u>0){s.textContent=R?R.emptyScript:"";for(let f=0;f<u;f++)s.append(d[f],S()),y.nextNode(),a.push({type:2,index:++o});s.append(d[u],S())}}}else if(s.nodeType===8)if(s.data===at)a.push({type:2,index:o});else{let d=-1;for(;(d=s.data.indexOf(g,d+1))!==-1;)a.push({type:7,index:o}),d+=g.length-1}o++}}static createElement(t,e){const i=$.createElement("template");return i.innerHTML=t,i}}function x(r,t,e=r,i){var n,c;if(t===v)return t;let s=i!==void 0?(n=e._$Co)==null?void 0:n[i]:e._$Cl;const o=C(t)?void 0:t._$litDirective$;return(s==null?void 0:s.constructor)!==o&&((c=s==null?void 0:s._$AO)==null||c.call(s,!1),o===void 0?s=void 0:(s=new o(r),s._$AT(r,e,i)),i!==void 0?(e._$Co??(e._$Co=[]))[i]=s:e._$Cl=s),s!==void 0&&(t=x(r,s._$AS(r,t.values),s,i)),t}class kt{constructor(t,e){this._$AV=[],this._$AN=void 0,this._$AD=t,this._$AM=e}get parentNode(){return this._$AM.parentNode}get _$AU(){return this._$AM._$AU}u(t){const{el:{content:e},parts:i}=this._$AD,s=((t==null?void 0:t.creationScope)??$).importNode(e,!0);y.currentNode=s;let o=y.nextNode(),n=0,c=0,a=i[0];for(;a!==void 0;){if(n===a.index){let l;a.type===2?l=new O(o,o.nextSibling,this,t):a.type===1?l=new a.ctor(o,a.name,a.strings,this,t):a.type===6&&(l=new Rt(o,this,t)),this._$AV.push(l),a=i[++c]}n!==(a==null?void 0:a.index)&&(o=y.nextNode(),n++)}return y.currentNode=$,s}p(t){let e=0;for(const i of this._$AV)i!==void 0&&(i.strings!==void 0?(i._$AI(t,i,e),e+=i.strings.length-2):i._$AI(t[e])),e++}}class O{get _$AU(){var t;return((t=this._$AM)==null?void 0:t._$AU)??this._$Cv}constructor(t,e,i,s){this.type=2,this._$AH=h,this._$AN=void 0,this._$AA=t,this._$AB=e,this._$AM=i,this.options=s,this._$Cv=(s==null?void 0:s.isConnected)??!0}get parentNode(){let t=this._$AA.parentNode;const e=this._$AM;return e!==void 0&&(t==null?void 0:t.nodeType)===11&&(t=e.parentNode),t}get startNode(){return this._$AA}get endNode(){return this._$AB}_$AI(t,e=this){t=x(this,t,e),C(t)?t===h||t==null||t===""?(this._$AH!==h&&this._$AR(),this._$AH=h):t!==this._$AH&&t!==v&&this._(t):t._$litType$!==void 0?this.$(t):t.nodeType!==void 0?this.T(t):Pt(t)?this.k(t):this._(t)}O(t){return this._$AA.parentNode.insertBefore(t,this._$AB)}T(t){this._$AH!==t&&(this._$AR(),this._$AH=this.O(t))}_(t){this._$AH!==h&&C(this._$AH)?this._$AA.nextSibling.data=t:this.T($.createTextNode(t)),this._$AH=t}$(t){var o;const{values:e,_$litType$:i}=t,s=typeof i=="number"?this._$AC(t):(i.el===void 0&&(i.el=P.createElement(mt(i.h,i.h[0]),this.options)),i);if(((o=this._$AH)==null?void 0:o._$AD)===s)this._$AH.p(e);else{const n=new kt(s,this),c=n.u(this.options);n.p(e),this.T(c),this._$AH=n}}_$AC(t){let e=ut.get(t.strings);return e===void 0&&ut.set(t.strings,e=new P(t)),e}k(t){q(this._$AH)||(this._$AH=[],this._$AR());const e=this._$AH;let i,s=0;for(const o of t)s===e.length?e.push(i=new O(this.O(S()),this.O(S()),this,this.options)):i=e[s],i._$AI(o),s++;s<e.length&&(this._$AR(i&&i._$AB.nextSibling,s),e.length=s)}_$AR(t=this._$AA.nextSibling,e){var i;for((i=this._$AP)==null?void 0:i.call(this,!1,!0,e);t!==this._$AB;){const s=rt(t).nextSibling;rt(t).remove(),t=s}}setConnected(t){var e;this._$AM===void 0&&(this._$Cv=t,(e=this._$AP)==null||e.call(this,t))}}class z{get tagName(){return this.element.tagName}get _$AU(){return this._$AM._$AU}constructor(t,e,i,s,o){this.type=1,this._$AH=h,this._$AN=void 0,this.element=t,this.name=e,this._$AM=s,this.options=o,i.length>2||i[0]!==""||i[1]!==""?(this._$AH=Array(i.length-1).fill(new String),this.strings=i):this._$AH=h}_$AI(t,e=this,i,s){const o=this.strings;let n=!1;if(o===void 0)t=x(this,t,e,0),n=!C(t)||t!==this._$AH&&t!==v,n&&(this._$AH=t);else{const c=t;let a,l;for(t=o[0],a=0;a<o.length-1;a++)l=x(this,c[i+a],e,a),l===v&&(l=this._$AH[a]),n||(n=!C(l)||l!==this._$AH[a]),l===h?t=h:t!==h&&(t+=(l??"")+o[a+1]),this._$AH[a]=l}n&&!s&&this.j(t)}j(t){t===h?this.element.removeAttribute(this.name):this.element.setAttribute(this.name,t??"")}}class Ht extends z{constructor(){super(...arguments),this.type=3}j(t){this.element[this.name]=t===h?void 0:t}}class Ut extends z{constructor(){super(...arguments),this.type=4}j(t){this.element.toggleAttribute(this.name,!!t&&t!==h)}}class Nt extends z{constructor(t,e,i,s,o){super(t,e,i,s,o),this.type=5}_$AI(t,e=this){if((t=x(this,t,e,0)??h)===v)return;const i=this._$AH,s=t===h&&i!==h||t.capture!==i.capture||t.once!==i.once||t.passive!==i.passive,o=t!==h&&(i===h||s);s&&this.element.removeEventListener(this.name,this,i),o&&this.element.addEventListener(this.name,this,t),this._$AH=t}handleEvent(t){var e;typeof this._$AH=="function"?this._$AH.call(((e=this.options)==null?void 0:e.host)??this.element,t):this._$AH.handleEvent(t)}}class Rt{constructor(t,e,i){this.element=t,this.type=6,this._$AN=void 0,this._$AM=e,this.options=i}get _$AU(){return this._$AM._$AU}_$AI(t){x(this,t)}}const F=E.litHtmlPolyfillSupport;F==null||F(P,O),(E.litHtmlVersions??(E.litHtmlVersions=[])).push("3.3.3");const It=(r,t,e)=>{const i=(e==null?void 0:e.renderBefore)??t;let s=i._$litPart$;if(s===void 0){const o=(e==null?void 0:e.renderBefore)??null;i._$litPart$=s=new O(t.insertBefore(S(),o),o,void 0,e??{})}return s._$AI(r),s};/**
 * @license
 * Copyright 2017 Google LLC
 * SPDX-License-Identifier: BSD-3-Clause
 */const b=globalThis;let T=class extends A{constructor(){super(...arguments),this.renderOptions={host:this},this._$Do=void 0}createRenderRoot(){var e;const t=super.createRenderRoot();return(e=this.renderOptions).renderBefore??(e.renderBefore=t.firstChild),t}update(t){const e=this.render();this.hasUpdated||(this.renderOptions.isConnected=this.isConnected),super.update(t),this._$Do=It(e,this.renderRoot,this.renderOptions)}connectedCallback(){var t;super.connectedCallback(),(t=this._$Do)==null||t.setConnected(!0)}disconnectedCallback(){var t;super.disconnectedCallback(),(t=this._$Do)==null||t.setConnected(!1)}render(){return v}};T._$litElement$=!0,T.finalized=!0,(vt=b.litElementHydrateSupport)==null||vt.call(b,{LitElement:T});const Z=b.litElementPolyfillSupport;Z==null||Z({LitElement:T}),(b.litElementVersions??(b.litElementVersions=[])).push("4.2.2");/**
 * @license
 * Copyright 2017 Google LLC
 * SPDX-License-Identifier: BSD-3-Clause
 */const zt={CHILD:2},Dt=r=>(...t)=>({_$litDirective$:r,values:t});class Lt{constructor(t){}get _$AU(){return this._$AM._$AU}_$AT(t,e,i){this._$Ct=t,this._$AM=e,this._$Ci=i}_$AS(t,e){return this.update(t,e)}update(t,e){return this.render(...e)}}/**
 * @license
 * Copyright 2017 Google LLC
 * SPDX-License-Identifier: BSD-3-Clause
 */class K extends Lt{constructor(t){if(super(t),this.it=h,t.type!==zt.CHILD)throw Error(this.constructor.directiveName+"() can only be used in child bindings")}render(t){if(t===h||t==null)return this._t=void 0,this.it=t;if(t===v)return t;if(typeof t!="string")throw Error(this.constructor.directiveName+"() called with a non-string value");if(t===this.it)return this._t;this.it=t;const e=[t];return e.raw=e,this._t={_$litType$:this.constructor.resultType,strings:e,values:[]}}}K.directiveName="unsafeHTML",K.resultType=1;/**
 * @license
 * Copyright 2017 Google LLC
 * SPDX-License-Identifier: BSD-3-Clause
 */let G=class extends K{};G.directiveName="unsafeSVG",G.resultType=2;const jt=Dt(G);/**
 * @license
 * Copyright 2017 Google LLC
 * SPDX-License-Identifier: BSD-3-Clause
 */const Vt=r=>(t,e)=>{e!==void 0?e.addInitializer(()=>{customElements.define(r,t)}):customElements.define(r,t)};/**
 * @license
 * Copyright 2017 Google LLC
 * SPDX-License-Identifier: BSD-3-Clause
 */const Bt={attribute:!0,type:String,converter:N,reflect:!1,hasChanged:B},qt=(r=Bt,t,e)=>{const{kind:i,metadata:s}=e;let o=globalThis.litPropertyMetadata.get(s);if(o===void 0&&globalThis.litPropertyMetadata.set(s,o=new Map),i==="setter"&&((r=Object.create(r)).wrapped=!0),o.set(e.name,r),i==="accessor"){const{name:n}=e;return{set(c){const a=t.get.call(this);t.set.call(this,c),this.requestUpdate(n,a,r,!0,c)},init(c){return c!==void 0&&this.C(n,void 0,r,c),c}}}if(i==="setter"){const{name:n}=e;return function(c){const a=this[n];t.call(this,c),this.requestUpdate(n,a,r,!0,c)}}throw Error("Unsupported decorator location: "+i)};function gt(r){return(t,e)=>typeof e=="object"?qt(r,t,e):((i,s,o)=>{const n=s.hasOwnProperty(o);return s.constructor.createProperty(o,i),n?Object.getOwnPropertyDescriptor(s,o):void 0})(r,t,e)}/**
 * @license
 * Copyright 2017 Google LLC
 * SPDX-License-Identifier: BSD-3-Clause
 */function Wt(r){return gt({...r,state:!0,attribute:!1})}/**
 * @license lucide v1.21.0 - ISC
 *
 * This source code is licensed under the ISC license.
 * See the LICENSE file in the root directory of this source tree.
 */const Ft={xmlns:"http://www.w3.org/2000/svg",width:24,height:24,viewBox:"0 0 24 24",fill:"none",stroke:"currentColor","stroke-width":2,"stroke-linecap":"round","stroke-linejoin":"round"};/**
 * @license lucide v1.21.0 - ISC
 *
 * This source code is licensed under the ISC license.
 * See the LICENSE file in the root directory of this source tree.
 */const ft=([r,t,e])=>{const i=document.createElementNS("http://www.w3.org/2000/svg",r);return Object.keys(t).forEach(s=>{i.setAttribute(s,String(t[s]))}),e!=null&&e.length&&e.forEach(s=>{const o=ft(s);i.appendChild(o)}),i},Zt=(r,t={})=>{const i={...Ft,...t};return ft(["svg",i,r])};/**
 * @license lucide v1.21.0 - ISC
 *
 * This source code is licensed under the ISC license.
 * See the LICENSE file in the root directory of this source tree.
 */const Kt=[["path",{d:"M12 8V4H8"}],["rect",{width:"16",height:"12",x:"4",y:"8",rx:"2"}],["path",{d:"M2 14h2"}],["path",{d:"M20 14h2"}],["path",{d:"M15 13v2"}],["path",{d:"M9 13v2"}]];/**
 * @license lucide v1.21.0 - ISC
 *
 * This source code is licensed under the ISC license.
 * See the LICENSE file in the root directory of this source tree.
 */const Gt=[["ellipse",{cx:"12",cy:"5",rx:"9",ry:"3"}],["path",{d:"M3 5V19A9 3 0 0 0 21 19V5"}],["path",{d:"M3 12A9 3 0 0 0 21 12"}]];/**
 * @license lucide v1.21.0 - ISC
 *
 * This source code is licensed under the ISC license.
 * See the LICENSE file in the root directory of this source tree.
 */const Jt=[["path",{d:"M20 10a1 1 0 0 0 1-1V6a1 1 0 0 0-1-1h-2.5a1 1 0 0 1-.8-.4l-.9-1.2A1 1 0 0 0 15 3h-2a1 1 0 0 0-1 1v5a1 1 0 0 0 1 1Z"}],["path",{d:"M20 21a1 1 0 0 0 1-1v-3a1 1 0 0 0-1-1h-2.9a1 1 0 0 1-.88-.55l-.42-.85a1 1 0 0 0-.92-.6H13a1 1 0 0 0-1 1v5a1 1 0 0 0 1 1Z"}],["path",{d:"M3 5a2 2 0 0 0 2 2h3"}],["path",{d:"M3 3v13a2 2 0 0 0 2 2h3"}]];/**
 * @license lucide v1.21.0 - ISC
 *
 * This source code is licensed under the ISC license.
 * See the LICENSE file in the root directory of this source tree.
 */const Qt=[["path",{d:"M22 17a2 2 0 0 1-2 2H6.828a2 2 0 0 0-1.414.586l-2.202 2.202A.71.71 0 0 1 2 21.286V5a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2z"}]];/**
 * @license lucide v1.21.0 - ISC
 *
 * This source code is licensed under the ISC license.
 * See the LICENSE file in the root directory of this source tree.
 */const Yt=[["path",{d:"M12 22v-5"}],["path",{d:"M15 8V2"}],["path",{d:"M17 8a1 1 0 0 1 1 1v4a4 4 0 0 1-4 4h-4a4 4 0 0 1-4-4V9a1 1 0 0 1 1-1z"}],["path",{d:"M9 8V2"}]];/**
 * @license lucide v1.21.0 - ISC
 *
 * This source code is licensed under the ISC license.
 * See the LICENSE file in the root directory of this source tree.
 */const Xt=[["path",{d:"M20 13c0 5-3.5 7.5-7.66 8.95a1 1 0 0 1-.67-.01C7.5 20.5 4 18 4 13V6a1 1 0 0 1 1-1c2 0 4.5-1.2 6.24-2.72a1.17 1.17 0 0 1 1.52 0C14.51 3.81 17 5 19 5a1 1 0 0 1 1 1z"}],["path",{d:"m9 12 2 2 4-4"}]],$t=22,te=1.75;function ee(r,t="step-icon"){return Zt(r,{width:$t,height:$t,stroke:"currentColor","stroke-width":te,class:t,"aria-hidden":"true"})}const ie={query:Qt,llm:Kt,mcp:Yt,atlas:Jt,validate:Xt,storage:Gt},se=".dc-m-0{margin:0}.dc-mx-1{margin-left:.25rem;margin-right:.25rem}.dc-mx-auto{margin-left:auto;margin-right:auto}.dc-mb-1{margin-bottom:.25rem}.dc-mb-16{margin-bottom:4rem}.dc-mb-2{margin-bottom:.5rem}.dc-mb-4{margin-bottom:1rem}.dc-mb-5{margin-bottom:1.25rem}.dc-mb-6{margin-bottom:1.5rem}.dc-mb-8{margin-bottom:2rem}.dc-flex{display:flex}.dc-grid{display:grid}.dc-hidden{display:none}.dc-h-0\\.5{height:.125rem}.dc-w-6{width:1.5rem}.dc-min-w-\\[5\\.5rem\\]{min-width:5.5rem}.dc-max-w-2xl{max-width:42rem}.dc-max-w-lp{max-width:72rem}.dc-max-w-xl{max-width:36rem}.dc-cursor-pointer{cursor:pointer}.dc-grid-cols-1{grid-template-columns:repeat(1,minmax(0,1fr))}.dc-flex-col{flex-direction:column}.dc-flex-wrap{flex-wrap:wrap}.dc-items-center{align-items:center}.dc-items-stretch{align-items:stretch}.dc-justify-center{justify-content:center}.dc-gap-1{gap:.25rem}.dc-gap-1\\.5{gap:.375rem}.dc-gap-3{gap:.75rem}.dc-gap-4{gap:1rem}.dc-rounded{border-radius:.25rem}.dc-rounded-lg{border-radius:.5rem}.dc-rounded-xl{border-radius:.75rem}.dc-border{border-width:1px}.dc-border-t{border-top-width:1px}.dc-border-md-primary{border-color:var(--md-primary-fg-color, #90a4ae)}.dc-bg-md-primary{background-color:var(--md-primary-fg-color, #90a4ae)}.dc-bg-md-surface{background-color:var(--md-default-bg-color, #ffffff)}.dc-p-3{padding:.75rem}.dc-p-4{padding:1rem}.dc-p-5{padding:1.25rem}.dc-p-6{padding:1.5rem}.dc-px-4{padding-left:1rem;padding-right:1rem}.dc-py-8{padding-top:2rem;padding-bottom:2rem}.dc-pt-6{padding-top:1.5rem}.dc-text-center{text-align:center}.dc-text-3xl{font-size:1.875rem;line-height:2.25rem}.dc-text-\\[0\\.65rem\\]{font-size:.65rem}.dc-text-base{font-size:1rem;line-height:1.5rem}.dc-text-lg{font-size:1.125rem;line-height:1.75rem}.dc-text-sm{font-size:.875rem;line-height:1.25rem}.dc-text-xl{font-size:1.25rem;line-height:1.75rem}.dc-text-xs{font-size:.75rem;line-height:1rem}.dc-font-bold{font-weight:700}.dc-font-semibold{font-weight:600}.dc-uppercase{text-transform:uppercase}.dc-leading-relaxed{line-height:1.625}.dc-leading-tight{line-height:1.25}.dc-tracking-\\[0\\.2em\\]{letter-spacing:.2em}.dc-tracking-tight{letter-spacing:-.025em}.dc-tracking-wide{letter-spacing:.025em}.dc-tracking-widest{letter-spacing:.1em}.dc-underline{text-decoration-line:underline}.dc-transition{transition-property:color,background-color,border-color,text-decoration-color,fill,stroke,opacity,box-shadow,transform,filter,backdrop-filter;transition-timing-function:cubic-bezier(.4,0,.2,1);transition-duration:.15s}.hover\\:dc-opacity-80:hover{opacity:.8}@media(min-width:640px){.sm\\:dc-grid-cols-2{grid-template-columns:repeat(2,minmax(0,1fr))}}@media(min-width:768px){.md\\:dc-block{display:block}.md\\:dc-gap-0{gap:0px}.md\\:dc-py-12{padding-top:3rem;padding-bottom:3rem}.md\\:dc-text-4xl{font-size:2.25rem;line-height:2.5rem}.md\\:dc-text-lg{font-size:1.125rem;line-height:1.75rem}}@media(min-width:1024px){.lg\\:dc-w-10{width:2.5rem}.lg\\:dc-grid-cols-4{grid-template-columns:repeat(4,minmax(0,1fr))}.lg\\:dc-text-5xl{font-size:3rem;line-height:1}}";var re=Object.defineProperty,oe=Object.getOwnPropertyDescriptor,J=(r,t,e,i)=>{for(var s=i>1?void 0:i?oe(t,e):t,o=r.length-1,n;o>=0;o--)(n=r[o])&&(s=(i?n(t,e,s):n(s))||s);return i&&s&&re(t,e,s),s};const k=[{id:"query",label:"Consulta NL",detail:"Pergunta em linguagem natural sobre o domínio laboratorial."},{id:"llm",label:"Agente LLM",detail:"Planeja tool calls e gera SQL sob orçamento de chamadas."},{id:"mcp",label:"Servidor MCP",detail:"Expõe tools tipadas: catálogo, schema, validação e execução."},{id:"atlas",label:"Apache Atlas",detail:"Catálogo canônico governa entidades, linhagem e metadados."},{id:"validate",label:"Validação SQL",detail:"Parse Calcite, aderência estrutural e execução Hive controlada."},{id:"storage",label:"Hive / HDFS",detail:"Dados massivos consultados sob ambiente laboratorial."}],ne=5e3;let H=class extends T{constructor(){super(...arguments),this.heading="Fluxo arquitetural interativo",this.activeIndex=0}connectedCallback(){super.connectedCallback(),this.startAutoAdvance()}disconnectedCallback(){super.disconnectedCallback(),this.stopAutoAdvance()}startAutoAdvance(){this.stopAutoAdvance(),this.timer=setInterval(()=>{this.activeIndex=(this.activeIndex+1)%k.length},ne)}stopAutoAdvance(){this.timer&&(clearInterval(this.timer),this.timer=void 0)}selectStep(r){this.activeIndex=r,this.startAutoAdvance()}renderStepIcon(r,t,e){const i=["step-icon-wrap",t?"is-active":"",e?"is-past":""].filter(Boolean).join(" ");return I`
      <span class=${i}>
        ${jt(ee(ie[r]).outerHTML)}
      </span>
    `}render(){const r=k[this.activeIndex];return I`
      <section
        class="dc-rounded-xl dc-border dc-border-md-primary/20 dc-bg-md-surface dc-p-6"
        aria-label=${this.heading}
      >
        <h2
          class="dc-m-0 dc-mb-6 dc-text-lg dc-font-semibold"
          style="color: var(--md-default-fg-color);"
        >
          ${this.heading}
        </h2>

        <div
          class="dc-mb-6 dc-flex dc-flex-wrap dc-items-stretch dc-justify-center dc-gap-1 md:dc-gap-0"
          role="tablist"
          aria-label="Etapas do pipeline"
        >
          ${k.map((t,e)=>{const i=e===this.activeIndex,s=e<this.activeIndex;return I`
              <div class="dc-flex dc-items-center">
                <button
                  type="button"
                  role="tab"
                  aria-selected=${i}
                  aria-controls="mcp-step-panel"
                  class="dc-flex dc-min-w-[5.5rem] dc-flex-col dc-items-center dc-gap-1.5 dc-rounded-lg dc-border dc-p-3 dc-text-center dc-transition dc-cursor-pointer
                    ${i?"node-active dc-border-md-primary dc-bg-md-primary/10":""}
                    ${i?"":"dc-border-md-primary/20 hover:dc-border-md-primary/40"}"
                  style="color: var(--md-default-fg-color);"
                  @click=${()=>this.selectStep(e)}
                >
                  ${this.renderStepIcon(t.id,i,s)}
                  <span class="dc-text-[0.65rem] dc-font-semibold dc-leading-tight dc-uppercase dc-tracking-wide">
                    ${t.label}
                  </span>
                </button>
                ${e<k.length-1?I`
                      <div
                        class="dc-hidden md:dc-block dc-mx-1 dc-h-0.5 dc-w-6 lg:dc-w-10 dc-rounded
                          ${s||i?"line-active dc-bg-md-primary":"flow-connector-idle dc-bg-md-primary/20"}"
                        aria-hidden="true"
                      ></div>
                    `:null}
              </div>
            `})}
        </div>

        <div
          id="mcp-step-panel"
          role="tabpanel"
          class="dc-rounded-lg dc-border dc-border-md-primary/15 dc-p-4"
          style="background: color-mix(in srgb, var(--md-code-bg-color) 60%, transparent);"
        >
          <p
            class="dc-m-0 dc-mb-1 dc-text-xs dc-font-semibold dc-uppercase dc-tracking-widest"
            style="color: var(--md-primary-fg-color);"
          >
            Etapa ${this.activeIndex+1} de ${k.length}
          </p>
          <p
            class="dc-m-0 dc-mb-2 dc-text-base dc-font-semibold"
            style="color: var(--md-default-fg-color);"
          >
            ${r.label}
          </p>
          <p
            class="dc-m-0 dc-text-sm dc-leading-relaxed"
            style="color: var(--md-default-fg-color--light, var(--md-default-fg-color));"
          >
            ${r.detail}
          </p>
        </div>
      </section>
    `}};H.styles=[tt`
      ${X(se)}
    `,tt`
      :host {
        display: block;
        font-family: var(--md-text-font, system-ui, sans-serif);
      }

      .step-icon-wrap {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        color: var(--md-default-fg-color--light, #757575);
        transition: color 0.2s ease;
      }

      .step-icon-wrap.is-active {
        color: var(--md-primary-fg-color);
      }

      .step-icon-wrap.is-past {
        color: color-mix(in srgb, var(--md-primary-fg-color) 70%, transparent);
      }

      :host-context([data-md-color-scheme="slate"]) .step-icon-wrap {
        color: var(--md-default-fg-color--light);
      }

      :host-context([data-md-color-scheme="slate"]) .step-icon-wrap.is-past {
        color: color-mix(in srgb, var(--md-primary-fg-color) 85%, transparent);
      }

      :host-context([data-md-color-scheme="slate"]) .flow-connector-idle {
        background: color-mix(in srgb, var(--md-primary-fg-color) 35%, transparent);
      }

      @keyframes pulse-line {
        0%,
        100% {
          opacity: 0.35;
        }
        50% {
          opacity: 1;
        }
      }

      @keyframes pulse-node {
        0%,
        100% {
          box-shadow: 0 0 0 0 color-mix(in srgb, var(--md-primary-fg-color) 0%, transparent);
        }
        50% {
          box-shadow: 0 0 0 6px color-mix(in srgb, var(--md-primary-fg-color) 25%, transparent);
        }
      }

      .node-active {
        animation: pulse-node 1.6s ease-in-out infinite;
      }

      .line-active {
        animation: pulse-line 1.2s ease-in-out infinite;
      }
    `],J([gt({type:String})],H.prototype,"heading",2),J([Wt()],H.prototype,"activeIndex",2),H=J([Vt("mcp-architecture-viewer")],H);const ae=new Intl.DateTimeFormat("pt-BR",{month:"long",year:"numeric"});function _t(){const r=ae.format(new Date);document.querySelectorAll("[data-access-month-year]").forEach(t=>{t.textContent=r})}_t(),typeof document$<"u"&&document$.subscribe(()=>{_t()})})();
