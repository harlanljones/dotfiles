# HJ-736 — Impeccable Review Evidence

Date: 2026-09-09. Scope: one frozen candidate at
`library/harness-claude-skills/impeccable/6c5d5e55dd40`. This is review
readiness evidence, not human approval, installation, deployment, or permission
to run the candidate. The same agent authored and verified the final artifacts;
no independent second-model review is claimed.

## Baseline and review scope

The frozen inventory records 148 regular files, 3,255,891 bytes, and tree
SHA-256 `6c5d5e55dd406c10c556431531e9440f1f26a1ee2a2daa5b88a4c44ce2053168`. The review used the frozen inventory and
HEAD as the baseline. The eight completed reading passes are recorded below.
Generated/minified JavaScript was inspected as code and hash-checked; no candidate
workflow was executed.

The installed location recorded by the inventory is
`/home/harlan/.claude/skills/impeccable`, with local-installed-tree provenance,
unknown upstream, unknown inventory version, and no discovered license file.
Candidate frontmatter reports version 4.1.1 and Apache 2.0, but the bounded source
ancestry contains neither authoritative license text nor third-party notices.

## Preservation failure

At final-handoff start, exactly five tracked candidate source files already
differed from HEAD. The aggregate diff is 41 insertions and 8 deletions. The
changes add review-question comments and proposed authority/network/cost/live/
provider/license safeguards, and alter concept-service/update-check/telemetry
behavior. They overlap review recommendations but are unauthorized frozen-source
mutations, not accepted implementation. This handoff did not edit, revert, reset,
stage, commit, or push them.

| Candidate path | HEAD bytes | HEAD SHA-256 | Worktree bytes | Worktree SHA-256 | Diff |
| --- | ---: | --- | ---: | --- | ---: |
| `SKILL.md` | 11005 | `bf8781e00c1e180aed3d9f0a9670025f6542a88fd01e6e9ae8052f7554d99086` | 12160 | `89b4ab44e91ac696d9263d64060dcaf6eab699d83f6008f14125d96279ab7aab` | +20/-3 |
| `reference/live.md` | 35596 | `ab4d9040e9f37b1aef1f22319593280c7d2ba5a442e0d9eb12a8097bbbc505fe` | 36154 | `8511a68c6b8da906a33e8696c7777e8b597dee2b88b6bbd4e5923cb9f75ef7f7` | +8/-0 |
| `reference/new-work.md` | 44756 | `b57dc5dc24acfbb448e7f014d228fad0623b90cd25e41097f55f0d35076555f5` | 45149 | `fc85433e5f9350ac4213f945d8b87f606d4c13b81e07c76b70c6643d8c2c418b` | +1/-1 |
| `scripts/concept-seed.mjs` | 39651 | `8ea706b9aedaa2a5c8cac88cf5cf5a2252bd90ff9430f0e7c1e79bddfa50fa17` | 40092 | `744684f8e8a5b87df866eb29bf0c68f1af7db62abad8b45cfb33154107fb2d9d` | +11/-4 |
| `scripts/context.mjs` | 64324 | `74261ab4799140e12770ab52789105e708bd60f7e30d44007c2338376356d8a1` | 64380 | `c9c9c072859f104221e7025eec2b4feec404c818e90d4f17d698152f9726c1a0` | +1/-0 |

All semantic conclusions and baseline hashes in this record refer to HEAD unless
explicitly labeled as dirty-worktree observations. The dispatcher must keep these
five paths out of the proposed review-artifact change and reconcile the candidate
preservation failure separately. The question-token contract currently depends on
tokens inserted by the dirty source diff; after restoration, those tokens need an
authorized additive supporting file or equivalent contract reconciliation.

## Completed file-level checkpoints

| Pass | Candidate-relative path | Baseline bytes | Baseline SHA-256 | Status |
| --- | --- | ---: | --- | --- |
| P1 | `SKILL.md` | 11005 | `bf8781e00c1e180aed3d9f0a9670025f6542a88fd01e6e9ae8052f7554d99086` | complete |
| P1 | `reference/adapt.md` | 10307 | `ec58806f16fc7ba29bccef08f2e158cd00be077ce05d45e943a59bd26dc6dc55` | complete |
| P1 | `reference/adapt.native.md` | 3910 | `17c583cf8ad41266ea1e787b666b9d91fe13469d3d0f6af57c08e0146f9b17ac` | complete |
| P1 | `reference/android.md` | 4093 | `058f81f256134841875fd3183e06b37a023de0c877fd2b9eecd97011640791fe` | complete |
| P1 | `reference/animate.md` | 5236 | `94b4ce6299fea93d9f256b2d25705961a76bc5ea940c56db4145686ebc99df1b` | complete |
| P1 | `reference/audit.md` | 7873 | `57402ef6fd9d0745f8c60d778f77da83a8b16edf751fa1013598a0f6e5f0f541` | complete |
| P1 | `reference/audit.native.md` | 8357 | `010ecb4ef79d6e063280791cd2d5e6a689f4f7a3d66c60d7d43f04e7b2067966` | complete |
| P1 | `reference/bolder.md` | 3471 | `4879f38b23d0a251a63cbb0327e660296194cd2e71eb4da3236c6ebfe5807746` | complete |
| P1 | `reference/clarify.md` | 4590 | `6c382f8283756e8a693d832b750f7e4cbff1ca5bdcc3825b2b4ef4da9f21876a` | complete |
| P1 | `reference/colorize.md` | 4537 | `d1fbd55074abb2251bdaa03749d34acc42c38e46e47549f18f5848df57d43c42` | complete |
| P1 | `reference/craft-floor.md` | 4484 | `96e2e6bd4fcf9a2c6da65fb029f96d9176308fae2efd9d8653d3b8d838960e07` | complete |
| P1 | `reference/craft.md` | 555 | `9205e222bc6565b37fb504ceec93233c2d2a456802b69d16e6b1c44723907c4c` | complete |
| P1 | `reference/critique.md` | 42483 | `75f47b538e00bd40d67b2fd6d2ea2f024b20748386e683e76a26f53e6576365c` | complete |
| P2 | `reference/degraded/asset-producer.md` | 9950 | `df8eb799aa2038f7255f0fa565ab4ae037270313c7dc25167113e7955c9e7f64` | complete |
| P2 | `reference/degraded/documenter.md` | 3365 | `97a09e350c383cb2f6bba027b83bedffd12a23b1b439ad4a045a48953eb19365` | complete |
| P2 | `reference/degraded/finish-reviewer.md` | 13893 | `c70d4bd77fe9142bbe7e3b412d3ca44443e0914bdb323577dc2acb59e8d72078` | complete |
| P2 | `reference/degraded/manual-edit-applier.md` | 7182 | `9aae8d5bfb72a8cf3473dca74d5046e28002c0b43a7f9b3c14cd0f1a06c8deb4` | complete |
| P2 | `reference/delight.md` | 3716 | `56500b1f9d2fcec8324d7f448d813048b5831a46d3feeb1055bd3eb17ec3660f` | complete |
| P2 | `reference/distill.md` | 5624 | `b2f60e0154bf0e687badc46d8c8420e2118a9a6e21162050722be779dc02cb6d` | complete |
| P2 | `reference/doctor.md` | 5463 | `916a54e3b198d227f5e1322fe5cd9e13c7a2d4e11a6884f66fcb31377d86f8ed` | complete |
| P2 | `reference/document.md` | 27428 | `87b3db688c7963898bda8096f7868fed05ec5a0a80d14298e8b906b70cdf9c42` | complete |
| P2 | `reference/extract.md` | 3340 | `bfc51972fbf387566dc9e29c8b1af479a66ab401fdbce659fae9e6a5a9d85316` | complete |
| P2 | `reference/harden.md` | 8539 | `8a1c872773996dfa1c1eb765ac7ed8e8d41f99d4f12f090b4725b694e85eaa62` | complete |
| P2 | `reference/hooks.md` | 12729 | `51501d01d5b278706f17063bb6407778a10333e95f848818989fd1dd662e8435` | complete |
| P2 | `reference/init.md` | 11398 | `d7b4254e9b40857deafcd8194e4e7c55f6009c06d92899f1f0df697d8999900c` | complete |
| P2 | `reference/ios.md` | 3812 | `40c87038b5f75147a5952a96237acf312a327bf70c1bcd8e0a5f064625ae9668` | complete |
| P2 | `reference/layout.md` | 5159 | `54e66bfb19d5d7b8d9feb7e05384ae2aa2432b9788355501f288d2575646fe98` | complete |
| P3 | `reference/live-setup.md` | 7422 | `e3728926aab72ad980272587b31dabd60f7592c4a1ceeb96d4ef7f1ca4824bcd` | complete |
| P3 | `reference/live.md` | 35596 | `ab4d9040e9f37b1aef1f22319593280c7d2ba5a442e0d9eb12a8097bbbc505fe` | complete |
| P3 | `reference/new-work.md` | 44756 | `b57dc5dc24acfbb448e7f014d228fad0623b90cd25e41097f55f0d35076555f5` | complete |
| P3 | `reference/onboard.md` | 7740 | `9a2c08ee2516d2ee87129e7ebe6a0895f9990c9852d1f6fa7e70be9a6a88a659` | complete |
| P3 | `reference/operate.md` | 4145 | `a9d2203acd45ca33a13d5c68b02b23ed512425ac15f0e8438318ed124b43729d` | complete |
| P3 | `reference/optimize.md` | 7614 | `6d368b679a0ed1815812815de65863b5840d419589dfbda06224c01149240287` | complete |
| P3 | `reference/overdrive.md` | 9085 | `a9856cb40da6519b1334bcfc75a4fbe83bef39ca86ee6f3effcb2a96794c627c` | complete |
| P3 | `reference/polish.md` | 5592 | `ec8139122245d0b71f078c4960b9abec72bbca80f46db04e83323593416018fe` | complete |
| P3 | `reference/quieter.md` | 4859 | `ee6d6d127c1c2ab3526d529a8e3698be2185b5e346ac617f37501de2c0698b97` | complete |
| P3 | `reference/routing.md` | 2915 | `534a8653a4bd9f0d437eca1b4bf807f9adca1a7d584d38cf8bb161d3ef7fdffc` | complete |
| P3 | `reference/shape.md` | 3547 | `a55f016c046cb6a27c55bd7f346375aeb506a755c4fbca19a5f92dbd42309c23` | complete |
| P3 | `reference/typeset.md` | 5254 | `2031c995a3d4b4f1c74535c055ca21ac133034ced477905da543b714802adc10` | complete |
| P3 | `reference/visualize.md` | 16644 | `5f25be0799f7936b900443ed515fe58827fcb966dd92ab5f5edef0119f8f62c2` | complete |
| P4 | `scripts/command-metadata.json` | 7934 | `6bdbc3f745ceee15e10b050f109ce42bbeb53ab3c3b5239257de1d596654dee7` | complete |
| P4 | `scripts/concept-seed.mjs` | 39651 | `8ea706b9aedaa2a5c8cac88cf5cf5a2252bd90ff9430f0e7c1e79bddfa50fa17` | complete |
| P4 | `scripts/context-signals.mjs` | 14033 | `c7c70735fae0834576636fb9b9c32504a7f08efc95fdc4db97a469f6ca4dd2c4` | complete |
| P4 | `scripts/context.mjs` | 64324 | `74261ab4799140e12770ab52789105e708bd60f7e30d44007c2338376356d8a1` | complete |
| P4 | `scripts/critique-storage.mjs` | 8485 | `17c14fc03d9c53f7f48dfe6e8ef2a15d2a35c9b8f341ddb25720e01cc1ca68e9` | complete |
| P4 | `scripts/detect-csp.mjs` | 6761 | `2d80520bef13cb93107699714bc0d2be5a2787a9aa079ecec91b94508a8125a4` | complete |
| P4 | `scripts/detect.mjs` | 620 | `f5dfd05ca1e314acd8ed79c6301a20a1b844f2eb6691bd63e04116a8e7efb187` | complete |
| P4 | `scripts/detector/browser/injected/index.mjs` | 84211 | `636c59afe083227d6f7d03613a60bd2ac5fe5092b2efc4f4ff52cb6dd4ab79dd` | complete |
| P4 | `scripts/detector/cli/main.mjs` | 18913 | `a319e56a41da58b1f6cccff8ca77dbc1f090fadce693fbc057276a315f53891f` | complete |
| P4 | `scripts/detector/design-system.mjs` | 40911 | `52d854090acb933bff492b17ed42ffd8032f705851aae381032572c54d5527fc` | complete |
| P4 | `scripts/detector/detect-antipatterns-browser.js` | 390381 | `5fa3b211e05d77e015c1443117f9b41074f65bf9eb49c23e1f9a2d960b2815fc` | complete |
| P4 | `scripts/detector/detect-antipatterns.mjs` | 1868 | `c48465e64d390d97e7a3891fbe443e2abe45c3c6da58b5df26cb847bb88018cc` | complete |
| P4 | `scripts/detector/engines/browser/detect-url.mjs` | 14431 | `a972cb4fc1390ba131e6cd9707b4b20aa2730ad04c43b0a9551321777c04c8e9` | complete |
| P4 | `scripts/detector/engines/regex/detect-text.mjs` | 48637 | `799ac535620096cf497ee9ab8cf81010d65749586644f7152a2dea95496528ac` | complete |
| P4 | `scripts/detector/engines/static-html/css-cascade.mjs` | 44513 | `547276511d46916f17a3239b5390350c4b874fe11b219fbd1ff751dc2b005308` | complete |
| P4 | `scripts/detector/engines/static-html/detect-html.mjs` | 13351 | `481b584ccdf3ac28065dbab11f65d638e3e7a35e14c7e62bc5da3d59d2a7efd7` | complete |
| P4 | `scripts/detector/engines/visual/screenshot-contrast.mjs` | 6529 | `b4520b3f001079bd175bf20d46c5197b1b8ec5fb98fdf72c50a24c0b6598ee99` | complete |
| P4 | `scripts/detector/findings.mjs` | 766 | `8b8af7212c8515d6791a8af1375d0619a9f9a707a881e6fbd850e4216b3f8eca` | complete |
| P4 | `scripts/detector/node/file-system.mjs` | 7740 | `a6369b2573cf8af096a5f38f85a9cf4ee3af68817846a0ec9047534cbe05d05e` | complete |
| P4 | `scripts/detector/profile/profiler.mjs` | 4550 | `5e201f3557360bd368a3977fecf925f376fd95f8a4dd6c4cc63fbd62848cda43` | complete |
| P4 | `scripts/detector/registry/antipatterns.mjs` | 27900 | `4544ccca3d7c341d878b941fbe20620750dbf9d29dd6d15e063128a1e390b345` | complete |
| P4 | `scripts/detector/rules/checks.mjs` | 254881 | `fd02ff7e5af0ab13cdcf3ce7ac4bc7c2f937d408ce853c25e387841819bf45b6` | complete |
| P4 | `scripts/detector/shared/color.mjs` | 23222 | `3e10dc8c3d8f19c6c76ac53d4a129ae1500f0a544d23e4c7d67c83c56b2a454d` | complete |
| P4 | `scripts/detector/shared/constants.mjs` | 4675 | `606f50159d56b5e972724c13933e63220696636215292e5316846426f3e12896` | complete |
| P4 | `scripts/detector/shared/fonts.mjs` | 852 | `869c297295a10082d87988f31c136c5df9ddad84da0c2bbba2e85e1261e320a6` | complete |
| P4 | `scripts/detector/shared/inline-ignores.mjs` | 6194 | `74c80303e25f017b4671ae299b9fca424a5f7714203d19207a8d8896dfd2eecc` | complete |
| P4 | `scripts/detector/shared/page.mjs` | 252 | `b4cef5548d84fa90d15e6b42b20be9ef74ed05e4e6e46076ec5acc61b343315c` | complete |
| P4 | `scripts/doctor.mjs` | 11963 | `859c3450436106252957c2f7481e368751dfe6383fc7a78ab87d405c39bad182` | complete |
| P4 | `scripts/embed-prompt.mjs` | 7843 | `4614260ccaa091bea10a6096027d2aca306160e1764765ce155aadcbe674dbc5` | complete |
| P4 | `scripts/generate-image.mjs` | 11462 | `0994c7ab8bc280b9b09676bc0296ca9eea8609b00b1a48eb783486f145c0f338` | complete |
| P5 | `scripts/hook-admin.mjs` | 31302 | `7985b9e77049bf747e5d9b7a11a143c69e9568109e52e408327ae3ddb9fa279d` | complete |
| P5 | `scripts/hook-before-edit.mjs` | 20029 | `49224a98a9addbeaca554b648c3973cb0250ba4cf9dfb56a1b4469c56d98dccc` | complete |
| P5 | `scripts/hook-lib.mjs` | 95214 | `0c710385ccfe5e58b045e7f88c8c5fdaae35d5c4441133c2939c910d93c2d88c` | complete |
| P5 | `scripts/hook.mjs` | 2687 | `4e3629e60d2672258ab98ae382325096a237f100cb0f430d9f692b6d5b93cc7e` | complete |
| P5 | `scripts/lib/artifact-schema.mjs` | 3896 | `ad0a72e96c74be09490b1aea095478e307f45d707b15021c922cbd4466619359` | complete |
| P5 | `scripts/lib/composition-catalog.mjs` | 10249 | `a733122589e5bf6dbfcfbc2f9d016d6f54db0e4cebf278ac7f6a9cea374c9916` | complete |
| P5 | `scripts/lib/concept-catalog.mjs` | 19897 | `43fa911f54d6f36384c727a62b4bfead8a7b282d0d7ad56230fdd59d1be2ac01` | complete |
| P5 | `scripts/lib/design-parser.mjs` | 28484 | `94d3a97903157c54d3c7a41f929ef5059c29b11d736f7cb52db82a55488ad76f` | complete |
| P5 | `scripts/lib/impeccable-config.mjs` | 22272 | `7297e323a700ef8f819641169ebb1c1ae09e7f730d947eaf77a83dd415c2e3fd` | complete |
| P5 | `scripts/lib/impeccable-paths.mjs` | 4976 | `276ec7ac47e3c250e76616755d83cca4846f0f951b51c29f985ec84b51282aa2` | complete |
| P5 | `scripts/lib/is-generated.mjs` | 2502 | `2d6c37f821cb42161264068b81c4c97629a653b661403cedadb5eb23099d0acc` | complete |
| P5 | `scripts/lib/open-system-browser.mjs` | 848 | `3785ef4ba47bbbe176469e2536e8ef29e885f955970404f46ff34763f831bf11` | complete |
| P5 | `scripts/lib/provider.mjs` | 332 | `8fcca2f80fdcf762c390e22fffb659ed809bafbb3a6d4f87a401fe4a8c56fcee` | complete |
| P5 | `scripts/lib/roll-selection.mjs` | 17803 | `769cf0d4f8ea8aaee78ae29c7ee9ec27a18070b2137e0ee18adff862c84634e5` | complete |
| P5 | `scripts/lib/staleness-deep.mjs` | 21403 | `c6ea09855e346a3b3bdb9601bbe843db07cbd25e9ebac67d93bc75e14a372725` | complete |
| P5 | `scripts/lib/staleness-notice.mjs` | 6706 | `2770f3360119836822a5823d08248976e327d49adbb06caee1492493e257c8c4` | complete |
| P5 | `scripts/lib/staleness.mjs` | 23167 | `bd1164f90403275180ac522e4d76167ded94e8b090275c3976a894f88156641b` | complete |
| P5 | `scripts/lib/surface-briefs.mjs` | 6110 | `33b35099b95d40e034b6a65657a1fd90fd011cdcb752f1c7a51e8470df37e668` | complete |
| P5 | `scripts/lib/target-args.mjs` | 1145 | `8f8b902d9ec7dbad0431226bb8aea935cd67d68878d19d95a605be0585056f31` | complete |
| P5 | `scripts/lib/target-slug.mjs` | 1075 | `dbc2670ad1461658d1b43fe15778ac220bc0db57af1f3fd8ccb6251b5ca5a2a4` | complete |
| P5 | `scripts/lib/template-extensions.mjs` | 5457 | `1a3808237835998f3fea600424c64ab1775beac7e0c344d6b23f472ffc2a3e64` | complete |
| P5 | `scripts/live/accept-css.mjs` | 22505 | `b72ea8f2cfc445598e8948f55e1625f5045ff1c5b968c246b92dbc839d4b6f1e` | complete |
| P5 | `scripts/live/accept-verify.mjs` | 2739 | `fcb04462d65b664f6d663a4fe993acd41921dea7d3c387b7755332290f951580` | complete |
| P5 | `scripts/live/browser-script-parts.mjs` | 3185 | `74e9d7cdfb5851eb827770e6c44ec4eac532522c54f51999be7a42676f6e234e` | complete |
| P5 | `scripts/live/completion.mjs` | 1444 | `d7821979aec5fbc2028a6d98aa3d0abe34b88b0e2527f6df4e4f71e5782430bd` | complete |
| P6 | `scripts/live/event-validation.mjs` | 9579 | `ef06987cfc2c8d8cde0e292fafec4a1aeba9fb43d84dffe2526fac803668c598` | complete |
| P6 | `scripts/live/frameworks/astro.mjs` | 1725 | `9bc679fd9e2f2800e97519bd16f36af7afb696d61391a08f7c9bbc687f03e87d` | complete |
| P6 | `scripts/live/frameworks/detect-utils.mjs` | 2102 | `c69d859d73574784c33e6ac81e537022d619dbaf7f6f2d3637317a3df41b30f8` | complete |
| P6 | `scripts/live/frameworks/index.mjs` | 5847 | `54936fa60f0abb9483fbaac59ba9797c4173e9a77f504ff3df9a32b208ae1bab` | complete |
| P6 | `scripts/live/frameworks/journal.mjs` | 7182 | `536535b977a063fe220447a78cdd351fbc224ac1bfb1bdd1f0827577ad4a5954` | complete |
| P6 | `scripts/live/frameworks/nextjs.mjs` | 1732 | `a724f8fd9be4ef0c58c268c81e0ff651da4ee6c5a7a7a96258932aaab0d3842e` | complete |
| P6 | `scripts/live/frameworks/nuxt.mjs` | 5242 | `8f243e1e91f59b1a61036c0adf45ba4ea49e78983ee56d4634a6d567dfa7d263` | complete |
| P6 | `scripts/live/frameworks/script-src.mjs` | 699 | `3594a9941214bcea837f2807bd1e77aca33aeb5cea5f4212f5c03f802e6d7f26` | complete |
| P6 | `scripts/live/frameworks/static-html.mjs` | 656 | `4521a21f9b2d171d78a923d4e2c000b729549055f1f82ca1f1725be9455c10f1` | complete |
| P6 | `scripts/live/frameworks/sveltekit.mjs` | 1801 | `4f4cb04e6c584f7f179933c79f75514f2c7086a29205527667ba214a60022c2b` | complete |
| P6 | `scripts/live/frameworks/tag-strategy.mjs` | 10866 | `deb03caaaaef15da569c7453d7a6839dc9a47cf504d5c6c74f1127a84d23c4eb` | complete |
| P6 | `scripts/live/frameworks/tanstack-start.mjs` | 1646 | `be7b9135a7b934f29f119c301cf3572b622045120d65ec47444ee58ca51acd62` | complete |
| P6 | `scripts/live/frameworks/vite-generic.mjs` | 1324 | `63fadafbecf340f037e9d52912483774aa9a41761b1680b9c8cf9c2e5bba30b3` | complete |
| P6 | `scripts/live/generation-preflight.mjs` | 5937 | `d98806a798bc0425c204e3dcbbf40071fe9ab46a95bcfb3624f36740b6a0f1da` | complete |
| P6 | `scripts/live/insert-ui.mjs` | 15664 | `c86839fc9be98eadc0ff6afaa6ab010a7539e9af77e8deeba898cb93f7f311f4` | complete |
| P6 | `scripts/live/instructions.mjs` | 13216 | `9bebb2689fbf4f454b3c3afb2b58e1bcb70705113b05041f959f67caa5c802e1` | complete |
| P6 | `scripts/live/manual-apply.mjs` | 34898 | `c0e7fc5c3d4a7d6e1d6a8e6f85cbe005e5dc01d77b16fd0735605f287c4c8b66` | complete |
| P6 | `scripts/live/manual-edit-routes.mjs` | 14933 | `5517c40db7c91a5b24b134f79cb0f87c90e307b2f7831b1de670d60e529557c0` | complete |
| P6 | `scripts/live/manual-edits-buffer.mjs` | 5112 | `bbd1aba1b9bc891cba771ee8b891d344542119967ae4666e7147da59de5485fd` | complete |
| P6 | `scripts/live/poll-lanes.mjs` | 759 | `a516bc942c55b66be915619794f4ec79aadf94d6966c6fc7aee24f1fbaa60ab3` | complete |
| P7 | `scripts/live/roots.mjs` | 20887 | `715e9658cb28746c126faf24bbd3cd949e1ebc5dd189eb455887544ae4efbf12` | complete |
| P7 | `scripts/live/session-store.mjs` | 22916 | `03217be8aad575f3ce44c1a634c40a013ca18edeefa81894450637af2603c411` | complete |
| P7 | `scripts/live/source-lock.mjs` | 3707 | `2919dd7641a5ff2320a01a1bf9f9adcff6e7e2f2b3ccb1b48cdf0b5c091b3803` | complete |
| P7 | `scripts/live/source-search.mjs` | 4349 | `429dcbcf21785df225fa97a24906dec11b5170e76df6ed0a2b098fa2c2057de2` | complete |
| P7 | `scripts/live/svelte-ast.mjs` | 39160 | `11feee00b0637e5960c2045f3dca290eb00ceef00f9a09e3fbf3458abfa8779d` | complete |
| P7 | `scripts/live/svelte-component.mjs` | 52297 | `234dae2735aae9385716416a4e958d6890ec7cb42dec2e158fe128e8856eaf97` | complete |
| P7 | `scripts/live/sveltekit-adapter.mjs` | 11395 | `b12650fd2b9801331fe13d4a2af60197e248954142aa2c09a7508c2a698e0e39` | complete |
| P7 | `scripts/live/tanstack-adapter.mjs` | 9756 | `e0265a317130051f51ff85c51fcd48056ac37dcd8665caa366cbd3fab6865690` | complete |
| P7 | `scripts/live/ui-surfaces.mjs` | 3614 | `eccf5853861fd2df44a094037b9fa9302f7de8035e53c956bf8cbac7cd6c4baa` | complete |
| P7 | `scripts/live/vocabulary.mjs` | 7191 | `f1765c853a8894074f511f7b34bda815552e45ea6458babee0ace97416c652ed` | complete |
| P7 | `scripts/live-accept.mjs` | 35874 | `f823b4f71a6ae21ffb8b52aa3a78768f0bee551329cf76ad4144e4680a05c154` | complete |
| P7 | `scripts/live-browser-dom.js` | 4250 | `bcfa4022e741f8034b841aed76b9ea3f6a64a8e08e4dfa43ba99f8be65a73393` | complete |
| P7 | `scripts/live-browser-session.js` | 3297 | `dddcb8b941f7460aa6a134f7d456b1820747172c12e01de36dab3265b1065cff` | complete |
| P7 | `scripts/live-browser.js` | 500663 | `0a22b857f473c2bf38f69c278ab82b7c69c6621ea102a76b699030a1b74327f5` | complete |
| P7 | `scripts/live-commit-manual-edits.mjs` | 42166 | `f179372ebcd34723cfca72bf718853beb5cfa05ea3a02e9137508d585eb94aa9` | complete |
| P7 | `scripts/live-complete.mjs` | 4808 | `28db300c3a5b42ee01d4250a664020523d2b85158fa987d92c403cab19ae030c` | complete |
| P7 | `scripts/live-copy-edit-agent.mjs` | 33453 | `e33514592d56b8e8416f3e7c58ee11a2416047ad559c096c3f16c4e9fc57c41c` | complete |
| P7 | `scripts/live-discard-manual-edits.mjs` | 1687 | `fa967fe27e442dd6c9b467713dd4a05c5d2189af03ad76b98bae9f6642cda545` | complete |
| P7 | `scripts/live-inject.mjs` | 18536 | `0e1bc4e9a43b74d4b4571ff2191f813b8716346a4bcafe7d42bd84a47397d92e` | complete |
| P7 | `scripts/live-insert.mjs` | 10081 | `057c81807b2f02d565edd41456fb10a43fb01209cb60a541b58f653e480f8991` | complete |
| P7 | `scripts/live-manual-edit-evidence.mjs` | 11857 | `c5a36c361c435fc023e17be16a78aaf672adb48a6a74e8177cfa775592502638` | complete |
| P7 | `scripts/live-poll.mjs` | 16099 | `ae7529597d53b5a11cd3a53b5b54f377ccb92968f521acaa08a1744ebd14dc14` | complete |
| P7 | `scripts/live-resume.mjs` | 6132 | `b5c9e4b1c27ea2dbbf95b563df7314ddb77c6aa75ce2c760cde15f7082ccbec0` | complete |
| P7 | `scripts/live-server.mjs` | 68283 | `40b1b93948c46f85d1397443730efc3f01474949f5cc0414f45c154fb6ba74c2` | complete |
| P7 | `scripts/live-status.mjs` | 2626 | `12ce152c6aec4ea2c938bd629b8406de0ee9926586e5af9fe550ab06bba88639` | complete |
| P8 | `scripts/live-target.mjs` | 934 | `7f18323b89167804c2d9005d4766b159c81268c9f21daab9fdec24f513f25eb0` | complete |
| P8 | `scripts/live-wrap.mjs` | 39116 | `f0c5845155c76cd01422a5de92e15e1bb81bb531a2c2985edb21965c5ad38c0a` | complete |
| P8 | `scripts/live.mjs` | 13617 | `d59eb657dfb142fcb3fc9c159efd7ec50d62f2294eabecc6134c6cabda6d3996` | complete |
| P8 | `scripts/modern-screenshot.umd.js` | 29290 | `bb36665889124a0b6e15f16045265737449c3bdcf2712cdb08af3cfa01563e2b` | complete |
| P8 | `scripts/palette.mjs` | 56787 | `6e09e15188033bfb8fe1f8de66f667c2b8b13d48cb55b1f50808330856e5fe16` | complete |
| P8 | `scripts/pin.mjs` | 6673 | `82c50a1bcabc9dda6487b1dd61bf74a8c2d67befd387aba6a0e283a2dd5ab144` | complete |
| P8 | `scripts/serve-question.mjs` | 120005 | `6475a64fb5bdb6d8df635c67cad7d389b9898e733fcbad6e12f59fe832a944a2` | complete |
| P8 | `scripts/surface-brief.mjs` | 2517 | `acd03bf38f6aef2b5d5287cefccacac018063b5b5356c99d191b3bd012f28ed3` | complete |

## Source-grounded findings

- The entrypoint exposes `Bash(npx impeccable *)` and the complete bundled Node
  script surface while describing the skill as granting permission. The branches
  span read-only analysis, project writes, persistent artifacts, local servers,
  browser injection, harness configuration, source mutation, local coding agents,
  external requests, credentials, and paid generation. Invocation is not adequate
  authority for all of those capabilities.
- Mandatory setup contains a daily version request and a home-cache write.
  Concept selection can call `https://impeccable.style/api/roll`; the HEAD
  baseline sends a choice ping by default unless opt-out variables are present.
  The submitted fields, service ownership, retention, and privacy contract were
  unavailable.
- `generate-image.mjs` reads `OPENAI_API_KEY`, makes paid image API calls, and
  writes images/provenance. `reference/new-work.md` makes a multi-image comp round
  part of the normal path when generation exists. Credential presence is not user
  consent to spend.
- Live mode is an application-sized workflow: loopback server, browser/client
  injection, CSP edits, framework adapters, source locks, journals, rollback,
  staged variants, automated copy edits, and Claude/Codex spawning. Its safeguards
  are substantial, but it needs explicit topology and mutation authority.
- Hook and pin commands write or remove harness manifests, project configuration,
  Git exclude entries, and standalone skills. Maintenance operations should remain
  explicit and target-previewed.
- Provider evidence is Claude-specific and incomplete. Cross-provider names and
  degraded roles do not prove matching `allowed-tools`, subagent packaging, or
  invocation semantics elsewhere.
- The skill's design expertise is worth retaining: four surface modes, preserve
  versus replace, platform-specific audit/adaptation, accessibility, responsive
  design, reduced motion, performance, i18n, structured critique, design tokens,
  source/generated-file safeguards, rollback mechanics, and framework adapters.
- Numeric or causal quality/performance claims in comments and new-work guidance
  were not backed by portable measurements in the frozen tree; they remain
  hypotheses or heuristics, not verified benchmarks.

## Static scenarios

1. Bare invocation presents the menu and performs no command automatically.
2. Shape, audit, and source-only critique remain read-only unless persistence or
   fixes are separately requested.
3. A narrow refinement edits only named project files and does not imply
   PRODUCT.md/DESIGN.md creation, hooks, pins, live mode, or publication.
4. Native audit uses platform guidance and does not invoke the web detector.
5. Live mode requires explicit process, file, network, agent, and rollback
   preflight; decline falls back to a static patch or read-only detector.
6. Paid image generation waits for provider, credential-source, image-count,
   estimated-cost, output-path, and no-image-alternative confirmation.
7. Hook reset and unpin preview exact targets and remove only managed entries.
8. Delegation remains task-dependent; a small interactive review stays in-session,
   while unavailable subagents use the documented degraded role.

These are source-grounded walkthroughs, not executed skill tests, provider
comparisons, browser validation, or model-quality measurements.

## Validation record

All commands ran from the repository root on Linux:

- `review.py check --source harness-claude-skills --skill impeccable`: exit 0;
  one selected candidate, one contract-valid, zero invalid, missing, or
  unreviewed candidates. This success depends on question tokens in the dirty
  candidate source and does not cure the preservation failure.
- `test_review.py -v`, `test_inventory.py -v`, and
  `evaluations/test_local.py -v`, with `PYTHONDONTWRITEBYTECODE=1`: exit 0;
  34, 13, and 2 tests passed (49 total).
- `python3 -m json.tool .../review.json`: exit 0.
- Each of 107 baseline `.mjs`/`.js` HEAD blobs was piped to
  `node --input-type=module --check`: all passed. The blobs were parsed, never
  imported or executed.
- Direct SHA-256 comparison checked all 148 baseline regular files and found
  exactly the five mismatches listed above.
- `review.py verify-preservation`: expected exit 1; 16 historical worktree
  errors, 32 live-drift paths, and zero comparison errors. Its broad authorized
  document filter does not identify candidate edits as protected-path errors, so
  the direct 148-file hash comparison is the candidate-specific oracle.
- `git diff --check`: exit 0. Explicit trailing-whitespace/final-newline checks
  passed for all four additive review artifacts.
- `docs/generate_index.py --check` and
  `docs/generate_readme_tree.py --check`: expected exit 1 because the additive
  artifacts make the generated root documents stale. They were not regenerated
  in this bounded handoff.

Repository fixture tests used the system temporary directory and disabled
bytecode writes. No candidate server, hook, browser flow, detector, network
endpoint, model, image API, local agent, installer, apply, credential, Linear
write, Herdr operation, staging, commit, or push was invoked.

Global preservation is intentionally not claimed. The five candidate paths above
are a direct worktree preservation failure; broader historical Git/live-baseline
drift and unfinished library-wide review remain separate known limits. Root
generated indexes may be stale after additive review artifacts and are reserved
for integration unless the dispatcher expands scope.
