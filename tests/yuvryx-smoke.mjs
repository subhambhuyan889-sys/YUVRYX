import fs from "node:fs";
import assert from "node:assert/strict";

const html = fs.readFileSync(new URL("../index.html", import.meta.url), "utf8");

const nav = [...html.matchAll(/<button[^>]*data-v="([^"]+)"/g)].map(m => m[1]);
const views = [...html.matchAll(/<(?:section|div)[^>]*class="[^"]*\bview\b[^"]*"[^>]*id="([^"]+)"/g)].map(m => m[1]);

assert.ok(nav.length > 0, "No navigation targets found");
assert.ok(views.length > 0, "No view sections found");

for (const id of nav) {
  assert.ok(views.includes(id), `Navigation target has no view: ${id}`);
}

assert.ok(html.includes("function show(id)"), "Navigation controller missing");
assert.ok(html.includes("function applyPaidLocks()"), "Paid-access guard missing");
assert.ok(html.includes("prefers-reduced-motion"), "Reduced-motion accessibility support missing");

console.log(`YUVRYX smoke test passed: ${nav.length} navigation targets mapped to ${views.length} views.`);
