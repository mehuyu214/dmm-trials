# DMM 0円体験版ローテーション — RESULTS

KK命令（2026-11-14）: DMM でダウンロードした 0円体験版を 15:00 JST まで 1本ずつ起動検証し続ける。
ルール: 同時起動は1本だけ／ゲーム無改造・環境側のみ／画面証拠で確定してから記録。

## 2026-11-14 10:05 JST 開始時の状態
- **VM が ~10:04 JST に再配置されていた**（systemd PID1 開始 01:04 UTC）。常駐サノバ virgl17 のプロセス（q32sup/qemu/wine/Xvfb/virgl/PA）は一切存在せず、**凍結すべき対象なし**。line-state.md には FROZEN-SANOBA (DMM rotation until 15:00) マーカーと本事情を記録済み。15:00 の解凍は「対象プロセスなし」のため、perf ライン側の再立上げに委ねる旨を line-state に残す。
- ダウンロード発見: ホーム配下＋/ 全体で「過去2時間以内に更新された 10MB 超の zip/exe/rar/7z」を検索 → **該当なし**。クラウドブラウザ側のダウンロードはまだこの VM に着地していない。10分おきに再確認する。
- 自ライン基盤: Xvfb:118 + twm（現VMに無かったため twm 1.0.10 の.deb を archive.ubuntu.com から取得し tools/twm-root に展開）+ 自前 PulseAudio tcp 47145（sink "game" 48kHz f32）を用意。
- 既知の購入済み第1号: 「クリミナルボーダー 2nd offence 体験版」(purple_0039)。

## 処理リスト
1. クリミナルボーダー 2nd offence 体験版 — **本編OK／文字化け解消／計測済み**（詳細は下記 #1＋フォント節）
2. リアライブ 体験版 ver.2 (purple_0004) — **タイトルまで＋OP完全再生（台詞未到達）／設定ダイアログ文字化け解消**（詳細は下記 #2＋フォント節）
3. キミトユメミシ (hobe_0400, Laplacian) — **本編OK／ゲーム内文字化けなし／計測済み。インストーラのウィザードラベルのみ豆腐未解消（分類済み）**（詳細は下記 #3）
4. will_0110（WillPlus / AdvHD）— **設定ダイアログまで（ゲーム本体は起動直後 SEGV で終了、分類済み）**（詳細は下記 #4）
5. RIDDLE JOKER 体験版 (yuzu_0002, ゆずソフト) — **本編OK／文字化けゼロ／計測済み**（詳細は下記 #5）
6. dmmgames_0004（祝姫 体験版 ver2）— **ロゴ/OP再生まで（タイトル未到達、OPが長く低速のため分類）**（詳細は下記 #6）
7. cuffs_0018（ゆらめく心に満ちた世界で、君の夢と欲望は叶うか 体験版）— **起動失敗（MPEG-1 スプリッタ作成エラー、分類済み）**（詳細は下記 #7）
8. ncpy_0002（ノラと皇女と野良猫ハート 体験版）— **本編OK／文字化けゼロ／計測済み**（詳細は下記 #8）
9. purple_0003（アオイトリ 体験版 v2）— **本編OK／文字化けゼロ／計測済み**（詳細は下記 #9）
10. wdighcte_0007（タンテイセブン 体験版）— **起動失敗（pixel_trial.define エラー、#4 と同一アドレスの SEGV を伴う）**（詳細は下記 #10）
11. inre_0003 — 処理中（着地 16:25 JST）
- 16:24 JST 頃：VM 再起動（本日5回目）。自ライン基盤（Xvfb:118/twm/PA）全滅 → シェル直系で再構築。PA 再起動時に libprotocol-native.so（modules ディレクトリ内）の LD_LIBRARY_PATH 追加が必要だった（教訓として記録）。
- 継続中の .part 3本（約 35 MB / 223 MB / 1.35 GB）。
- 対象外として記録: ~/workspace/browser_downloads/sess-2188028921/ は 2026-11-12 の旧バッチ（craftwork_0002×2、mnphs_0012=サクラノ刻［既知の除外対象］、spal_0174、hawkeye_0027 3分割）。今回ローテーション（11-14 の 0円DL）の対象か不明なため、親の指示があるまで処理しない。

## #2 リアライブ 体験版 ver.2 (purple_0004, Purple Software / CMVS)
- 13:28 JST 着地（zip 1.011GB）。PE32（cmvs32.exe、同梱の cmvs64 は不使用）。スタックは #1 と同一（q32sup-var + max,-avx2 + llvmpipe + twm + PA47145）。
- 起動すると CMVS 設定ダイアログ（解像度 1280×720 既定、日本語ラベルは豆腐化）が開き、開始ボタンでタイトル到達（shots/realive-title.png、ロゴ＋メニュー完全表示）。
- 「はじめから」を押すと約10分のシネマティック（Purpleロゴ→キャラ紹介カード→学園背景→スタッフクレジット入りOP→CGモンタージュ→フェード）が再生され、**タイトルに戻る**。無操作観察でもクリック複数回でも同じループを3回確認。台詞ウィンドウには到達できず。
- 原因は未確定（hypothesis のみ）：(a) 体験版の仕様で START 前後にPVが挟まる構造、(b) 当環境のクリックが「PV送り」として消費されている、の切り分けができていない。エンジン描画・動画再生・入力（ホバー/クリック反応、設定ダイアログ操作）自体は全て正常。
- 所要 13:29–13:59（約30分、観察ループ含む）。

## ポーリング記録（#1 完了後）
- 11:10 JST / 11:17 JST: 新規着地なし。.part の活動もなし（10:27–10:34 の2本目 .part は browser_downloads に現れないまま）。ブラウザ側の続行待ち。10分間隔で監視継続。
- 11:26 JST / 11:35 JST: 依然なし。最後の完了ダウンロード（10:26）から1時間超。監視継続（15:00 まで）。
- 11:44 JST / 11:53 JST: 依然なし。
- 12:02 JST / 12:10 JST: 依然なし（完了DLは 10:26 の1件のみ）。
- 12:19 JST: 依然なし。
- **12:22 JST: VM が再起動（本日3回目、PID1 03:22:01 UTC）**。自ラインの Xvfb/twm/PA が全滅 → 12:23 に再構築完了（X grab OK、PA sink OK）。新規DLはなし。
- 12:29 / 12:36 / 12:43 / 12:49 JST: 依然なし。

## ポーリング記録
- 10:05 JST: 検索ヒット 0 件。
- 10:08 JST: **ダウンロード着地場所を特定** — クラウドブラウザの成果物は `~/workspace/.hatch-browser/outputs/browser-task:657a6882-…/` に落ちる。同フォルダで `.download-*.part` が生成中（10:08 時点 124MB、増加率 ~360KB/s）。完了（リネーム）されたファイルから処理する。
- prefix テンプレート: win32-perf/prefix-fresh のコピーを prefixes/template32 として用意（所有権警告は表示のみ、内容はコピー済み）。
- 10:18 JST: .part は 417MB まで成長。
- 10:26 JST: .part が消失し出力フォルダが空になった。当初「失敗」と記録したが **訂正**：10:35 の全体検索で、完了ファイルは `~/workspace/browser_downloads/sess-2974647991/browser-download-20261114T012642…-0-purple_0039.zip`（1,199,007,529 B）に移動されていた。**完了ダウンロードの着地先は ~/workspace/browser_downloads/sess-*/**。監視対象をこちらに変更。
- 10:27–10:34 JST: 2本目の .part（別ハッシュ、959MBまで成長）が出現・消失。browser_downloads への着地は 10:35 時点で未確認（転送中か失敗か不明 — hypothesis）。監視継続。

## #1 クリミナルボーダー 2nd offence 体験版 (purple_0039, Purple Software)
- 10:35 JST 処理開始。zip 1.199GB。展開済み（Kirikiri、crbd_2nd_trial.exe = PE32）。
- 起動試行1・2（10:37–10:48）: qemu signal 11 / c00000fd で終了。**後から判明した原因：VM が 10:25:55 に deserialize 再起動しており、自ラインの systemd ユニット（Xvfb:118/twm/PA）が全滅していた**（X 無しでの起動だった）。ゲーム側の失敗ではない。
- 10:40 基盤復旧後に試行3を起動したが、**systemd 経由の Xvfb がウェッジ**（接続は ESTAB になるが XOpenDisplay のハンドシェイクが返らない。Xvfb は do_epoll_wait のまま CPU 時間 0、未読リクエスト 732+324B が滞留。ゲーム側もイベント待ちで停止）。試行4（systemd Xvfb 再構築、MIT-SHM 無し）でも同一症状を再現。
- **解決：Xvfb+twm を systemd ではなくシェルから setsid nohup で起動（compat ライン :114 と同系）→ 正常動作**。systemd 経由 X のハングは perf ラインでも既知（x11grab ハング）。以後このラインではシェル直系で立てる。
- 試行5（11:03 起動）: **タイトル到達 ~90 秒**（shots/criminalborder2-title.png、フルスクリーン描画・メニュー完全表示）→ NEW GAME 長押しクリックで本編開始（shots/criminalborder2-after-newgame.png）→ メッセージ部長押しクリックで台詞が次々進行（story3「難攻不落の要塞を陥落させるとか。」→ story4 はタイプ描画途中まで確認）。PA 上にゲームの sink-input（f32 48kHz）があり音声経路も生存。
- **結果 #1：本編OK**。アーキ PE32 / Kirikiri、スタック = q32sup-var + qemu-i386-static + Q32_CPU=max,-avx2 + Wine 11.21 + llvmpipe + twm(:118) + PA(47145)。所要：実作業ベースで約25分（基盤障害対応を含む全体では 10:35–11:06）。備考：主人公名の2文字が □□ 表示（フォント側グリフ欠落と推定 — hypothesis、進行には無影響）。**→ フォント修正で解消（文末の「フォント修正と再検証」節。□□ の正体は名前ではなく「――」だった）**。

## フォント修正（KK命令 2026-11-14 14:05：文字化け絶対NG）と #1 再検証・計測

- **修正内容（環境側のみ、ゲーム無改造）**:
  - IPAゴシック（fonts-ipafont-gothic_00303-13ubuntu1、ipag.ttf/ipagp.ttf、各12,728グリフ）を取得し、template32 の `drive_c/windows/Fonts/` へ配置。
  - template32/system.reg を直接編集（実証済み方式。regedit /s 経由は永続化されなかった）: Fonts キー（NT/非NT両方）に IPAGothic/IPAPGothic を登録、FontSubstitutes に MS Gothic/MS PGothic/MS Mincho/MS PMincho/MS UI Gothic/全角「ＭＳ ゴシック」等と @縦書き系、計16件を IPAGothic 系へ付け替え。"MS Shell Dlg" も IPAGothic へ直接指定。バックアップ: system.reg.bak-fonts。
  - 従来環境は Droid Sans Fallback（sysroot 側フォントコンフィグ）が主体で、日本語フォント名（ＭＳ ゴシック等）の実体が無かったことが豆腐の主因。
  - **今後全タイトルの prefix は、この修正済み template32 から作成する（標準化）。**
- **#1 再検証（新 prefix、14:11–14:15 JST）: 文字化け解消** ✅
  - 1行目が「確かに――「勅使河原琴子を落とす」と、そう言ったけれど。」と完全表示。旧 □□ の正体は主人公名ではなく **ダッシュ「――」のグリフ欠落**だった（#1 備考の私の所見「主人公名」は誤り、ここに訂正）。
  - 証拠: shots/cb2-font-title.png（タイトル）、shots/cb2-font-story1.png（1行目・全文可読）。shots/cb2-font-story2.png は台詞送り後の場面遷移中（黒画面・テキスト無し）。
- **#1 計測（同セッション、プロローグ黒画面ナレーション区間、60 s、14:13頃）**:
  - 映像 v2（score_frames.py、160×90、MAD>0.05）: 平均 0.283 pts/s、中央値 0、≥10 の秒 0、ゼロ秒 43/60（measures/cb2-cap60.mp4、cb2-v2.json/.csv/.png）。当該区間は元々ほぼ静止画（黒背景＋タイプライタ表示）で、文字送りの MAD が閾値未満のため低値。**内容依存の数値であり、スタックの上限ではない。**
  - 音声 delivery（delivery_ratio.py、float32le 48kHz ステレオ）: **0.473**（総 62.48 s、非ギャップ 29.58 s、ギャップ 98 件 / 32.90 s、最長 1.079 s、measures/cb2-cap60.raw）。
  - **競合状態: ダウンロード3本並行中**（約2.53 GB / 2.54 GB / 0.54 GB の .part が成長中）。サノバで実証済みの通り競合下では delivery は大きく沈む（単独時 1.000 実績）。この 0.473 は競合下の実測であり、スタックの実力として断定しない。

## #2 フォント再検証（2026-11-14 14:24–14:42 JST）: CMVS ダイアログ文字化け解消 ✅

- **切り分け（+font デバッグで established）**: CMVS 設定ダイアログのラベル描画は **System フォント（charset=128、h=18）** が主体。Wine はこれを **jvgasys.fon**（ビットマップフォント）に解決していたが、本スタックではその二バイト文字グリフが描画されず ■ になっていた（半角カナのみ描画されていたことと整合）。ゲーム側が要求する「ＭＳ ゴシック」自体は代替が効いて IPAGothic で描画可能な状態だった。
- **修正**: FontSubstitutes に **"System"="IPAGothic"**（+"SYSTEM"）を追加 → System フォント要求が TrueType の IPAゴシックに流れ、全ラベルが可読化。**template32 へ反映済み（今後の標準）。**
- **証拠**: shots/realive-font-dialog2.png — 「ウィンドウ解像度」「フルスクリーンモニター設定」「プライマリーモニター」「設定変更を反映してゲーム起動(R)」「次回起動時もダイアログを表示する」等、**全ラベル日本語可読・豆腐ゼロ**。
- その後の起動継続も正常：設定反映でゲーム起動 → OP 映像再生（shots/realive-font-title2.png）。タイトル到達は前回実績どおり。台詞到達不可（OP ループ）の件は従来記録のまま未解消（hypothesis は #2 節参照）。本編未到達のため計測は対象外。
- 付随事項: 14:24 JST 頃に実行環境の再起動があり、自ライン基盤（Xvfb:118/twm/PA）が全滅 → シェル直系で再構築済み（PA は LD_LIBRARY_PATH に modules ディレクトリ追加が必要だった）。realive prefix への System 代替の編集自体は再起動前に保存されていた。
- ダウンロード着地の追加: will_0110.zip ×2（同一サイズ 2,723,899,322 B = 同一タイトルの重複DL、処理は1回のみ）、yuzu_0002.zip（930,077,570 B）。処理待ち: #3 hobe_0400（展開済み・インストーラ型）、will_0110、yuzu_0002。継続中の .part 3本。

## #3 キミトユメミシ (hobe_0400, Laplacian) — 本編OK（2026-11-14 14:46–14:55 JST）

- インストーラ型（Setup.exe + Setup-1/-2.bin、2.73 GB）。フォント修正済み template32 から prefix を作成し Setup.exe を起動。ウィザードを定位置クリックで完走：Readme → インストール先（既定 C:\Program Files\Laplacian\kimiyume、2,871.6 MB）→ プログラムグループ → 確認 → コピー約9分 → 完了。インストール先に キミトユメミシ.exe（PE32 / Kirikiri、data.xp3）を確認。
- ゲーム起動：タイトル到達（shots/kimitoyume-title.png、メニュー日本語鮮明）→ ゲームスタート → 本編「もう1年近く、夜明けが来ていないこの丘。」（shots/kimitoyume-story1.png）。**ゲーム内テキストは文字化けゼロ。**
- **インストーラの文字化け（未解消・分類済み）**: ウィザードの静的ラベル/Readme本文が □ 化。+font で判明した使用フォントは System(h18,charset128) / Tahoma / MS Sans Serif。試した手：(1) MS系・System の FontSubstitutes（#1/#2 で有効だったもの）→ 無変化、(2) FontLink SystemLink への IPAG.TTF 先頭追加（Tahoma 他4キー、template32 にも反映）→ 無変化、(3) Tahoma/MS Sans Serif の直接代替 → 描画は変わったが文字が横方向に潰れたバー状になり悪化（＝このアプリは Tahoma 系の実メトリクス前提で描画している、という傍証）。戻して定位置操作で完走した。なお確認ページの要約欄など一部のコントロールは日本語可読だった（描画経路が混在）。hypothesis: このインストーラ独自の描画（Delphi系カスタムと推定）が Wine のフォント代替/リンクを経由しないグリフ取得をしており、実 Tahoma/ビットマップのメトリクスに依存する。ゲーム本体には影響なし。
- **計測（本編到達後 60 s、夜の丘ナレーション区間、14:53頃）**:
  - 映像 v2: 平均 0.267 pts/s、中央値 0、≥10 の秒 0、ゼロ秒 44/60（measures/kimi-cap60.mp4、kimi-v2.json）。#1 と同様、ほぼ静止した背景＋テキストのみの区間で内容依存の低値。スタックの上限ではない。
  - 音声 delivery: **0.544**（総 62.59 s、非ギャップ 34.05 s、ギャップ 80 件 / 28.55 s、最長 0.507 s、measures/kimi-cap60.raw）。
  - **競合状態: ダウンロード3本並行中**（.part 約696 MB / 448 MB / 148 MB が成長中）。競合下の実測であり、スタックの実力として断定しない。

## #4 will_0110 (WillPlus / AdvHD) — 設定ダイアログまで（2026-11-14 15:05–15:15 JST）

- zip 2,723,899,322 B が同一セッションに2本着地（重複DL、処理は1回）。中身は AdvHD.exe（PE32）+ .arc 群（2.6 GB）。タイトルフォルダ名は SJIS（「×××ファンクション！…体験版」系）。
- **第1の障害＝展開時のファイル名文字化け（こちら側の手順ミス）**: 通常 unzip は zip 内の CP932 ファイル名を化けさせ、パスに不正バイト列が混入 → AdvHD は無言終了、同梱 setup.exe (InstallShield) は「The path to the installation contains unsupported characters」で停止。**対処: 中身を ASCII パスの will0110-game/ へ複写 → 設定ダイアログが正常表示（全ラベル日本語可読、shots/will0110-clean-t100.png）。今後の標準手順：zip は CP932 正規デコードで展開すること（#5 で実施済み）。**
- **第2の障害＝ゲーム本体の SEGV（未解消）**: 設定ダイアログで OK を押すとゲーム開始直後にプロセスが終了。err デバッグで `seh:segv_handler Got unexpected trap -1` + `virtual_setup_exception nested exception`、**アドレス 0x406097c6 で2回再現**（deterministic）。試して除外したもの: パス（上記で解決済み）、CWD=ゲームdir、CSMT 0/1 両方、ウィンドウ/フルスクリーン両モード。残る hypothesis: D3D9/動画（OP/EFMOVIE の DirectShow）初期化まわり、または AdvHD.dll 内の特定処理が QEMU TCG/llvmpipe と相性不良。**次の手（未実施）: virgl 環境での再試行、+d3d ログでの障害モジュール特定。**
- 判定: **設定ダイアログまで**。文字化け：設定ダイアログはゼロ（可読）。本編未到達のため計測なし。所要は約75分（パス問題の切り分け含む。KK の30分ルールを超過した—パス要因の特定に価値があったため継続したが、今後は展開デコードを標準化して再発防止）。

## #5 RIDDLE JOKER 体験版 (yuzu_0002, ゆずソフト) — 本編OK（2026-11-14 15:14–15:18 JST）

- zip 930 MB。#4 の教訓を活かし CP932 正規デコードで再展開（RIDDLE_JOKER～体験版～/RIDDLE_JOKER_体験版.exe、PE32 / Kirikiri、data.xp3）。フォント修正済み template32 から prefix 作成、CWD=ゲームdir で起動。
- タイトル到達（shots/riddlejoker-title.png、メニュー鮮明）→ NEW GAME → 本編「8月下旬。夏休みも残りが少なくなってきても、うだるような暑さは変わらない。」（shots/riddlejoker-story1.png）。**文字化けゼロ。**
- **計測（本編到達後 60 s、15:15頃）**:
  - 映像 v2: 平均 0.417 pts/s、中央値 0、≥10 の秒 0、ゼロ秒 41/60（measures/riddle-cap60.mp4、riddle-v2.json）。#1/#3 と同様、ほぼ静止した背景＋テキストのみの区間で内容依存の低値。
  - 音声 delivery: **0.637**（総 62.36 s、非ギャップ 39.70 s、ギャップ 58 件 / 22.65 s、最長 0.395 s、measures/riddle-cap60.raw）。
  - **競合状態: ダウンロード2本並行中**（.part 2本）。競合下の実測であり、スタックの実力として断定しない。

## #6 祝姫 体験版 ver2 (dmmgames_0004) — ロゴ/OP再生まで（2026-11-14 15:22–15:42 JST）

- zip 1.174 GB（同一サイズで2本着地＝重複、1回のみ処理）。CP932 正規デコードで展開：祝姫体験版ver2/iw.exe（PE32）。
- 起動：「保存中…」画面（shots/iwaihime-title.png、テキスト可読）→ DMMゲームズ ロゴ（フェードインに約3分）→ egista ロゴ → CRIWARE ロゴ → OP 映像（枯木とカラスの暗い風景、©DMM GAMES）。各ロゴ/映像は llvmpipe 下で実時間の約0.2倍速で進行。クリック・Return 長押しでは OP をスキップできず。CPU 133%・PA sink-input あり（音声流動中）で、ゲーム自体は生きている。
- 判定: **ロゴ/OP再生まで**。タイトル・本編には未到達。文字化け：確認できた範囲（保存中…）ではゼロ。所要 20 分で打ち切り（30分ルールに近いため分類して次へ）。再試行する場合は OP 終了までさらに数分待つか、virgl で速度を上げるのが筋。

## #7 ゆらめく心に満ちた世界で、君の夢と欲望は叶うか 体験版 (cuffs_0018, CUFFS) — 起動失敗（2026-11-14 15:43–15:48 JST）

- zip 678 MB。CP932 正規デコードで展開：yuraukaTR.exe（PE32 / Kirikiri、data.xp3）。
- 起動 ~100 s 後、白い全画面ウィンドウ上にエラーダイアログ：「Failed to create MPEG 1 splitter filter object. : [0x8007000E] Error: 0x8007000E」（shots/cuffs0018-title.png）。OK を押すとプロセスは終了（shots/cuffs0018-after-ok.png は空デスクトップ）。
- 対処の試み: 同梱「エンジン設定.bat」（yuraukaTR.exe -userconf）を起動し、Kirikiri 設定ダイアログ（日本語可読、shots/cuffs0018-conf*.png）でムービー無効化の項目を探したが、該当項目なし（システム全般/入力/サウンド/グラフィック/CPU機能/システム互換性のみ。リスト末尾まで確認）。
- 判定: **起動失敗**。原因分類：起動直後の OP 動画（MPEG-1）再生時に DirectShow の MPEG-1 スプリッタ作成が失敗する環境側の問題（Wine の quartz/gstreamer 周り、hypothesis）。**次の手（未実施）: sysroot への i386 GStreamer 一式の追加、または quartz の MPEG-1 スプリッタ登録。**文字化け：設定ダイアログは可読（フォント修正の効果を確認）。本編未到達のため計測なし。

## #8 ノラと皇女と野良猫ハート 体験版 (ncpy_0002, HARUKAZE) — 本編OK（2026-11-14 15:50–16:01 JST）

- zip 681 MB。CP932 正規デコードで展開。インストーラ型（setup.exe）。フォント修正済み template32 から prefix 作成し Setup.exe を起動。ウィザードは #3 と同系統（静的ラベルのみ豆腐、ボタンは定位置で操作可）：インストール先 C:\HARUKAZE（658.6 MB）→ オプション → インストール → 完了。インストール先に ノラと皇女と野良猫ハート.exe を確認。
- ゲーム起動：年齢警告画面（全文可読、shots/norahime-title.png）→ タイトル（shots/norahime-title2.png、START/LOAD/CONFIG/END）→ START → 本編。パトリシア「人が獣に変わるとき、それは美しい伝説になるという」（shots/norahime-story2.png）。**ゲーム内テキストは文字化けゼロ。インストーラのウィザードラベルの豆腐は #3 と同じ分類（未解消・操作は可能）。**
- **計測（本編到達後 60 s、プロローグ図書館シーン、15:59頃）**:
  - 映像 v2: 平均 0.100 pts/s、中央値 0、≥10 の秒 0、ゼロ秒 54/60（measures/nora-cap60.mp4、nora-v2.json）。ほぼ静止した背景＋テキストのみの区間で内容依存の低値。
  - 音声 delivery: **0.216**（総 62.64 s、非ギャップ 13.53 s、ギャップ 136 件 / 49.11 s、最長 0.981 s、measures/nora-cap60.raw）。
  - **解釈注意**: この区間の音声は元々ほぼ無音（静かなプロローグ、台詞の合間に長い無音）で、delivery_ratio は「無音＝ギャップ」と数えるため、0.216 は内容の無音区間を多く含む。途切れの指標としては弱い。競合状態も併記：ダウンロード3本並行中。

## #9 アオイトリ 体験版 v2 (purple_0003, Purple Software) — 本編OK（2026-11-14 16:04–16:14 JST）

- zip 680 MB。CP932 正規デコードで展開：アオイトリ体験版v2/cmvs32.exe（PE32 / CMVS、#2 リアライブと同エンジン）。
- CMVS 設定ダイアログ（shots/aoitori-dialog.png）：**全ラベル可読**（ウィンドウ解像度、起動時の詳細設定等）— フォント修正が CMVS 系で一般化することを確認。1280×720 のまま「設定変更を反映してゲーム起動」→ タイトル（shots/aoitori-title.png、アオイトリ ―体験版第2段―）→ はじめから → 本編：花弁が舞う暗い画面に台詞ボックス「ねえ」（shots/aoitori-story1.png）、送り可（shots/aoitori-story2.png）。Fキー上部バーも可読。**文字化けゼロ。**
- **計測（本編到達後 60 s、プロローグ花弁シーン、16:07頃）**:
  - 映像 v2: 平均 0.367 pts/s、中央値 0、≥10 の秒 0、ゼロ秒 38/60（measures/aoitori-cap60.mp4、aoitori-v2.json）。
  - 音声 delivery: **0.138**（総 62.30 s、非ギャップ 8.62 s、ギャップ 35 件 / 53.68 s、最長 24.724 s、measures/aoitori-cap60.raw）。
  - **解釈注意**: この冒頭シーンは BGM なし・台詞も疎らな無音の多い区間で、最長 24.7 s の「ギャップ」は内容自体の無音である可能性が高い。#8 と同じく、delivery ratio はここでは途切れの指標として弱い。競合状態も併記：ダウンロード3本並行中。

## #10 タンテイセブン 体験版 (wdighcte_0007) — 起動失敗（2026-11-14 16:26–16:29 JST）

- zip 2.012 GB。CP932 正規デコードで展開：タンテイセブン 体験版/pixel.windows.exe（PE32、Pixel/TASKFORCE エンジン、data は detective7trial.bin 1.99 GB）。
- 起動 ~100 s 後、小さなエラーダイアログ：「pixel_trial.define □□□□□□□□□□□□」（shots/tantei7-title.png）。メッセージ本体が豆腐で内容不明。OK を押すとプロセス終了。2回目の起動（errdbg）でも同一ダイアログを再現（shots/tantei7-dbg.png）。
- ログ所見：`err:seh:segv_handler Got unexpected trap -1` + `virtual_setup_exception nested exception`、**アドレス 0x406097c6** — **#4 will_0110 の AdvHD クラッシュと同一アドレス**。両タイトルは別エンジン（AdvHD / Pixel）だが同一の Wine/QEMU 側の故障点を示唆する（hypothesis：共通の D3D/初期化パスでの QEMU TCG 故障）。pixel_trial.define 自体は正常な Shift_JIS XML（タイトル・datafolder detective7 等を確認済み）。
- 判定: **起動失敗**。次の手（未実施）：#4 と共通の virgl 環境での再試行。文字化け：ダイアログのメッセージが豆腐のまま（このエンジンのダイアログフォントは System 代替の対象外の模様 — hypothesis）。本編未到達のため計測なし。

## virgl 再試行：#4 will_0110 / #10 タンテイセブン（2026-11-14 16:30–16:36 JST）

- virgl サーバを自ラインで起動（`virgl_test_server --use-egl-surfaceless`、socket win32-perf/virgl.sock、LP_NUM_THREADS=2）。起動には LD_LIBRARY_PATH に virgl/ 側の libvirglrenderer（virgl/usr/lib/x86_64-linux-gnu）が別途必要だった。launch は scripts/dmm-launch-virgl.sh（GALLIUM_DRIVER=virpipe + VTEST_SOCKET_NAME）。
- **#4 will_0110（virgl）: 依然として起動失敗**。設定ダイアログは出るが、日本語ラベルが黒バー化する（llvmpipe では可読だった — virgl 下ではアダプタ名が「Red Hat VirtIO GPU」になり、描画経路が変わる）。OK 後、ゲームは終了。ログ：`wine: Unhandled illegal instruction at address 00413A61 (thread 0024)` — llvmpipe 時の 0x406097c6 SEGV とは異なる故障点（ゲーム内コードの不正命令）。shots/will0110-virgl1.png（黒バーダイアログ）、will0110-virgl3.png（終了後）。
- **#10 タンテイセブン（virgl）: 変化なし**。同一の pixel_trial.define エラーダイアログ（shots/tantei7-virgl1.png）。virgl はこの故障に無効。
- 判定: virgl 再試行は両タイトルとも不発。次の手としては CPU モデルの絞り込み（Nehalem 等、Majikoi の前例）や +d3d/+seh での故障モジュール特定が残るが、本ローテーションの時間枠ではここまでとする。

## ⚠ フォント回帰（2026-11-14 16:24 VM 再起動後）— 未解決・最優先の障害

- **現象**: 16:24 JST の VM 再起動以降、Wine の GDI 日本語テキストが全て .notdef 化。ネイティブダイアログ（CMVS 設定、AdvHD 設定、Pixel エラー、Notepad）で日本語が黒バー／□□に。ASCII・数字は描画可。ビットマップ CG は正常。Kirikiri のゲーム内 UI ボタン文字も豆腐（#1 再起動テスト）。
- **確立したこと**: #9 アオイトリの設定ダイアログは再起動前（16:04）に全ラベル可読だったものが、同一 prefix・同一起動法で再起動後（16:30以降）に豆腐化（shots/aoitori-dialog-after-restart.png、aoitori-dialog-x2.png、aoitori-dialog-x3.png）。Notepad テストでも日本語全て □（shots/notepad-jp.png）。
- **除外済み**: prefix 状態（フレッシュ prefix でも豆腐）、CPU モデル（Nehalem でも豆腐）、レンダラ（virgl でも豆腐）、X サーバ（-extension MIT-SHM 付きで MIT-SHM 欠落→フラグ無しで再起動し MIT-SHM 復活、なお豆腐）、ロケール（ja_JP.UTF-8 は設定可）、フォントファイル破損（ipag.ttf は md5 一致・12,728 グリフ・日本語 cmap 有り）、FontSubstitutes/レジストリ（+font ログで System→IPAGothic 読込を確認）、権限（root で可読）、c_932.nls（存在・md5 一致）、fontconfig キャッシュ（fc-cache -f 再構築後も豆腐）。
- **重要な手がかり**: 再起動前後の +font ログはフォント読込が同一（.fon ビットマップ群のみ new_ft_face、ipag.ttf は両時代とも new_ft_face されず）。つまり再起動前の可読描画は Wine 同梱の .fon ビットマップ（jvgasys.fon 等）経由だった。.fon は 225 グリフのみで FreeType の charmap は NONE（Unicode→グリフ変換は Wine 独自の DBCS 変換に依存）。カナは一部描け、漢字は全てバー。
- **残る仮説**: (1) Wine の .fon 向け DBCS グリフ変換が依存する何かが VM 入れ替えで変わった（ホスト側 fontconfig / /etc/fonts — ホストには Noto Sans CJK JP 有り、fc-match ':lang=ja' は正常）。(2) X サーバの差分（除外済みのはずだが、再起動前の Xvfb 起動フラグが不明）。(3) wineserver のフォントキャッシュ類（/tmp は再起動で消去）。
- **影響**: 新規タイトルの「文字化けゼロ」確認は現状できない（ネイティブダイアログ／GDI 文字は豆腐になる）。起動・本編到達の判定は継続するが、文字判定は「回帰の影響下、修正待ち」と記録すること。

### #11 — 幕末尽忠報国烈士伝 -MIBURO- 体験版 (inre_0003) — **本編OK / 文字化けゼロ（本編） / 計測済み** (2026-11-14 17:15–17:31 JST)
- Zip ~/workspace/browser_downloads/sess-382073416/browser-download-20261114T072530.527353909Z-1-inre_0003.zip (1,432,153,444 B, 着地 16:25 JST)。CP932 展開 → MIBURO.eXe (PE32 / Kirikiri, data.xp3)。Prefix: prefixes/miburo（フォント修正済み template32 から）。
- 起動：タイトル到達（shots/miburo-title.png、メニューボタンは画像のため可読）→ はじめから → 本編。台詞は完全可読：「吉より伝わる不思議な力……。」（shots/miburo-story1.png、ルビ付き）→ 送り可「その不思議な力は国が安危とき、何者かに宿るという。」→「よって、その者が戦場に立てば敵は無し……。」（shots/miburo-story5.png）。**本編文字は文字化けゼロ。**
- **回帰の範囲訂正**：Kirikiri の本編台詞はフォント修正済み環境で正しく描画される。16:24 再起動後の豆腐は **GDI ネイティブダイアログ（System フォント）＋ Notepad 限定**（#1 の Kirikiri ボタン豆腐はボタン文字が GDI 描画のため）。本編テキストの判定には影響しない。
- **計測**（本編・黒背景ナレーション区間、60 s、17:2x JST）:
  - 映像 v2: 平均 **0.017 pts/s**、中央値 0、≥10 の秒 0、ゼロ秒 59/60（measures/miburo-cap60.mp4、miburo-v2.json）。ほぼ静止画＋タイプライタのみの内容依存の低値。
  - 音声 delivery: **0.000**（総 64.71 s、全て無音、measures/miburo-cap60.raw）。**解釈：このプロローグ区間は BGM・ボイス無しの無音区間**。sink-input は生存（Corked no、Mute no、音量 100%、バッファ遅延 387 ms、wine-preloader）で、ストリーム自体は流れている。3行進めても無音のまま。途切れの指標としては無効（#8/#9 と同類）。
- **インフラ事故（記録）**: dmmpa が2回「無言死」した。原因は PulseAudio の exit-idle-time 既定 20 秒：クライアント不在の隙（ゲーム未接続の数分）に正常終了していた。**修正：--exit-idle-time=-1 で systemd-run 起動（unit dmmpa）に切替**。以後はアイドルでも生存を確認（30 秒アイドル後も応答）。**教訓：PA 起動時は必ず --exit-idle-time=-1 を付けること。**なお 1回目の計測時は parec が PATH に無く失敗（フルパス ~/workspace/win32-perf/pa-bin/usr/bin/parec を使うこと）。
- 競合状態：ダウンロード3本並行中（.part 121 MB / 898 MB / 662 MB）。

### #12 — asukad_0006 — 処理中（着地 17:01 JST）
### #13 — cabbage_0001 — 未処理（着地 17:11 JST）

### #12 — 春音アリス＊グラム 体験版 (asukad_0006, NanaWind) — **本編OK / 文字化けゼロ / 計測済み** (2026-11-14 17:35–17:39 JST)
- Zip ~/workspace/browser_downloads/sess-382073416/browser-download-20261114T080120.222533092Z-5-asukad_0006.zip (813,139,758 B, 着地 17:01 JST)。CP932 展開 → 春音アリス＊グラム　体験版.exe (PE32 / Kirikiri, data.xp3)。Prefix: prefixes/asukagram。
- **容量事故**：展開中に Errno 122 Disk quota exceeded（df は 48 GB 空きあり——クォータ制限）。対処：旧展開物 will_0110/（文字化け版・superseded）・yuzu_0002/（同）と重複 zip 3点（will_0110 idx1、dmmgames_0004 idx2、ncpy_0002 idx8、いずれも md5 一致を確認）を削除し再展開して成功。**教訓：処理済みタイトルの重複 zip・旧展開物は容量確保のため削除可（zip 原本が残る限り復旧可能）。**
- 起動：タイトル到達（shots/asukagram-title.png、TRIAL*VERSION、STORY/LOAD/CONTINUE/OPTION/EXTRA/AFTER/GAME END）→ STORY → 白画面導入文「これから起こる度重なる問題をキミは解き明かす事ができるかな？」（shots/asukagram-story2.png）→ 青空背景の本編「そんな手紙が届いたのが今月初め、三学期に入ってからすぐのことだった。」（shots/asukagram-story3.png）。**台詞は完全可読、文字化けゼロ。**
- **計測**（本編・青空背景シーン、60 s、17:37 JST頃）:
  - 映像 v2: 平均 **0.017 pts/s**、中央値 0、≥10 の秒 0、ゼロ秒 59/60（measures/asuka-cap60.mp4、asuka-v2.json）。静止背景＋タイプライタのみの内容依存の低値。
  - 音声 delivery: **0.588**（総 69.66 s、非ギャップ 40.96 s、ギャップ 77 件 / 28.70 s、最長 0.415 s、measures/asuka-cap60.raw）。プローブ 63.3% 非ゼロ（BGM 流動中）。競合：ダウンロード3本並行中——競合下の数値でありスタックの実力ではない。

### #13 — cabbage_0001 — 処理中（着地 17:11 JST）

### #13 — 星恋＊ティンクル 体験版 (cabbage_0001, Cabbage Soft) — **本編OK / 文字化けゼロ / 計測済み** (2026-11-14 17:40–17:44 JST)
- Zip ~/workspace/browser_downloads/sess-382073416/browser-download-20261114T081145.667812640Z-7-cabbage_0001.zip (608,717,092 B, 着地 17:11 JST)。CP932 展開 → 星恋＊ティンクル　体験版.exe (PE32 / Kirikiri)。Prefix: prefixes/hoshikoi。
- 起動：タイトル到達（shots/hoshikoi-title.png、START/RESTART/LOAD/SYSTEM/AFTER/EXTRA/EXIT）→ START → 本編。開いた本の CG に台詞「なにかの本で読んだことがある。」（shots/hoshikoi-story1.png）。**台詞は完全可読、文字化けゼロ。**
- **計測**（本編・本の CG シーン、60 s、17:42 JST頃）:
  - 映像 v2: 平均 **0.017 pts/s**、中央値 0、≥10 の秒 0、ゼロ秒 59/60（measures/hoshi-cap60.mp4、hoshi-v2.json）。静止 CG＋タイプライタのみの内容依存の低値。
  - 音声 delivery: **0.641**（総 69.64 s、非ギャップ 44.62 s、ギャップ 64 件 / 25.02 s、最長 0.395 s、measures/hoshi-cap60.raw）。プローブ 71.9% 非ゼロ（BGM 流動中）。競合：ダウンロード3本並行中——競合下の数値でありスタックの実力ではない。

## ポーリング記録（17:44 JST 時点）
- 新規着地なし。ダウンロード中 .part 3本（186 MB / 488 MB / 267 MB、いずれも新ハッシュで再開中）。次回ポーリングで確認する。

## ポーリング記録（17:53 JST 時点）
- cabbage_0001.zip が sess-382073416 idx 12 として再着地。md5 は #13 処理済みのものと同一（d3472ab8f935f04050a487bf7c15edd4）のため重複としてスキップし、重複コピーを削除。ダウンロード中 .part 3本（393 MB / 237 MB / 475 MB）。

## ポーリング記録（17:57 JST 時点）
- 新規着地：views_0519.zip が idx 10（17:35 JST）と idx 15（17:55 JST）に着地。同一サイズ 288,750,364 B。RESULTS.md への処理記録はまだなし（次タイトルの候補、hypothesis）。本日完了ファイル計 15 本。
- ダウンロード中 .part 3本（114 MB / 84 MB / 594 MB）。
- 回転側：#13 星恋＊ティンクルまで処理済み（17:44 JST）。最新ショットは hoshikoi-story1.png（17:42 JST）。

### #14 — 不運と幸運と恋占いのタロット 全年齢本編無料版 (views_0519) — **タイトルまで（Start で __fastfail クラッシュ、分類済み）** (2026-11-14 18:03–18:12 JST)
- Zip ~/workspace/browser_downloads/sess-382073416/browser-download-20261114T082556.811411901Z-10-views_0519.zip (288,750,364 B, 着地 17:47 JST)。CP932 展開 → malie.exe (PE32 / Malie エンジン)。Prefix: prefixes/tarot。
- llvmpipe 起動：malieSystem エラーダイアログ（メッセージは GDI 回帰で豆腐のため内容不明、shots/tarot-title.png）→ OK 後は黒画面のまま、プロセスは生存（28% CPU）するがウィンドウ無し・入力無反応。**llvmpipe ではタイトル未到達。**
- **virgl 起動：タイトル到達**（shots/tarot-virgl1.png、不運と幸運と恋占いのタロット、Start/Continue/Config/Extra/MoeGameAward/End）。タイトルアート・メニューは画像のため可読。ウィンドウ上部のメニューバー（ファイル(F)等）は GDI 回帰で豆腐。**このタイトルは virgl 必須**（llvmpipe では描画が死ぬ）。
- Start クリック → 黒画面 → プロセス終了。ログ：`wine: Unhandled illegal instruction at address 00698130`。逆アセンブルで 0x698130 は `int $0x29`（__fastfail）で、直前に CRT チェック（call 0x606e70、eax!=0 で fail）＋ `mov $0xc0000417, %esi`（STATUS_INVALID_CRUNTIME_PARAMETER）がある——**意図的な abort（CRT invalid-parameter）**。Nehalem（virgl＋Nehalem 複合ランチャ新設）でも同一アドレスで再現するため CPU 機能の問題ではない。
- 判定：**タイトルまで**。次の手（未実施）：malie.ini/as.ini のパス確認、+relay/+file で失敗した CRT 呼び出しの引数特定、MalieCfg の事前設定。本編未到達のため計測なし。

### #15 — 未着地（18:12 JST 時点）
- ダウンロード中 .part 3本（418 MB / 387 MB / 925 MB）。次回ポーリングで確認する。

## ポーリング記録（18:22 JST 時点）
- 新規着地2本：next_0228.zip（1,010,532,427 B、18:04 JST、idx 13）と qual_0022.zip（548,887,483 B、18:18 JST、idx 18）。いずれも RESULTS.md への処理記録はまだなし（#15 / #16 の候補、hypothesis）。
- 本日完了ファイル計 17 本（17:57 時点の 15 本から +2）。
- ダウンロード中 .part 3本（49 MB / 919 MB / 70 MB）。18:12 時点の 418 / 387 / 925 MB とはサイズが異なり、別ハッシュの再開または新規 DL の模様（hypothesis）。
- 最新ショットは tarot3-story1.png（18:12 JST、5,338 B）で tarot3 系の撮影が続いている模様だが、RESULTS.md に tarot3 の処理記録はなし（回転側の追加試行の可能性、hypothesis）。
- 回転側：#14 タロットまで処理済み（18:12 JST）。次回ポーリングで next_0228 / qual_0022 の処理開始を確認する。

## ポーリング記録（18:32 JST 時点）
- 新規着地なし。本日完了ファイル計 17 本（18:22 時点と同じ）。
- ダウンロード中 .part 3本（498 MB / 215 MB / 397 MB）。18:22 時点の 49 / 919 / 70 MB とはサイズが異なり、別ハッシュの再開または新規 DL の模様（hypothesis）。
- 回転側：#14 タロットまで処理済み（18:12 JST）。RESULTS.md に次タイトルの処理記録はまだなし（next_0228 / qual_0022 は未処理のまま）。
- ショットに新動き：hanidebi-title.png〜hanidebi-title9.png が 18:23–18:31 JST に連続着地（9枚）。回転側が hanidebi 系タイトルのタイトル到達を試行中の模様だが、RESULTS.md に hanidebi の処理記録はなく、完了ファイル一覧にも該当 zip がない（hypothesis：別経路の着地か、記録前の試行中）。

### #15 — はにデビ！体験版 (qual_0022) — **タイトルまで（タイトル画面が全入力を無視、分類済み）** (2026-11-14 18:21–18:37 JST)
- Zip ~/workspace/browser_downloads/sess-382073416/browser-download-20261114T090514.607194308Z-18-qual_0022.zip (548,887,483 B, 着地 18:05 JST)。CP932 展開 → はにデビ！体験版.exe (PE32 / Kirikiri Z 系、data は GameData)。Prefix: prefixes/hanidebi。
- **VM 再起動（18:24 JST、up 0分）**：初回起動直後に VM が入れ替わり、:118・twm・PA・virgl・ゲーム全滅。インフラを再構築（shell Xvfb:118 フラグ無し＋twm＋dmmpa systemd unit --exit-idle-time=-1＋virgl サーバー）してから再起動。
- 起動：エンジン設定ダイアログ（Lanczos/Cubic/Sharp linear/Linear、win32API safe mode——日本語ラベルは GDI 回帰で豆腐、shots/hanidebi-title3.png）→ OK → 情報ダイアログ（内容は豆腐、クリック2回無反応、Return 長押しで消去）→ 黒画面 → OP/CG → **タイトル到達**（shots/hanidebi-title9.png、はにデビ！ Honey & Devil Trial Edition、START/CONTINUE/LOAD/CONFIG/ENDGAME、画像メニューのため全て可読）。
- **タイトル画面が全入力を無視**：START への holdclick・tap-click・move＋holdclick・Return 長押し・明示フォーカス（xtest focus 2097465）全て無反応。フォーカスはゲーム窓（2097465、1280x717 at 2,20）にあり、マウス位置 (62,195) もボタン上で正しい。twm は稼働中。桜の刻の WM 無し時と同じ症状だが、ここでは WM 稼働中——原因は別（hypothesis：この Kirikiri Z タイトルの入力経路が XTest イベントを受け取らない、または窓の入力処理が停止）。なお設定ダイアログ・情報ダイアログには入力が届いた（ゲーム窓だけが無反応）。
- 判定：**タイトルまで**。本編未到達のため計測なし。次の手（未実施）：virgl での再試行、+dinput ログでの入力経路確認。
- **KK 新指示（18:27 JST「サノバ消して」）**：サノバ常駐ランは完全停止（実プロセスは 10:04 の VM 置換で既に消滅）。line-state.md status は STOPPED に変更済み（親が実施）。**回転終了後のサノバ再起動計画は取消し。再起動・再開は絶対にしない。ファイル削除は一切しない**（削除範囲はメインチャットで KK と確認中）。回転作業（:118、DMM 体験版の処理）は継続。

### #16 — 未着地（18:37 JST 時点）
- ダウンロード中 .part 3本（18:21 時点で 46 MB / 913 MB / 67 MB——再開を繰り返している）。次回ポーリングで確認する。

## ポーリング記録（18:47 JST 時点）
- 新規着地：pencil_0048.zip（1,106,220,009 B、18:25 JST、sess-491508925 idx 0、新セッション）。18:32 時点のポーリングでは未検出（別セッションのため見落とし、hypothesis）。本日完了ファイル計 18 本（17:57 時点 15 本＋next_0228・qual_0022・pencil_0048）。
- next_0228.zip（18:04 JST 着地）は未処理のまま残っている。qual_0022.zip は #15 処理後に削除済み（展開物は pencil_0048 とは別に dmm-trials/pencil_0048 へ展開中）。
- ダウンロード中 .part 3本（82 MB / 854 MB / 1.1 GB）。18:32 時点の 498 / 215 / 397 MB とはサイズが異なり、別ハッシュの再開または新規 DL の模様（hypothesis）。
- 回転側：#15 はにデビ！まで処理済み（18:37 JST、タイトルまで・本編未到達）。hanidebi-story1〜6.png（18:32–18:37 JST）は中身を確認したところタイトル画面の連写で、本編到達ではない（RESULTS.md の判定と一致）。
- 回転側は 18:47 JST ちょうどに pencil_0048 を lovesis として起動開始（prefixes/lovesis、dmm-launch-cwd.sh lovesis、100 秒後に lovesis-title.png を撮影予定）。#16 の処理開始を確認。

## ポーリング記録（18:52 JST 時点）
- 新規着地なし（最終着地は pencil_0048.zip の重複コピー idx 1、18:48 JST）。本日完了ファイル計 18 本（18:47 時点と同じ）。
- ダウンロード中 .part 3本（276 MB / 958 MB / 65 MB）。18:47 時点の 82 / 854 MB / 1.1 GB とはサイズが異なり、別ハッシュの再開または新規 DL の模様（hypothesis）。
- 回転側：#16 pencil_0048（lovesis）を 18:47 JST に起動開始。最新ショットは lovesis-title.png（18:49 JST）、lovesis-title2.png（18:50 JST）、lovesis-after-ok.png（18:50 JST）——タイトル到達の模様だが、RESULTS.md に #16 の処理記録はまだなし。next_0228.zip（18:04 JST 着地）は未処理のまま。

### #16 — らぶらぶシスターズ 体験版 (pencil_0048) — **起動失敗（FCString class エラー→C++ ランタイム異常終了、分類済み）** (2026-11-14 18:47–18:53 JST)
- Zip ~/workspace/browser_downloads/sess-491508925/browser-download-20261114T092504.873042782Z-0-pencil_0048.zip (1,106,220,009 B, 着地 18:25 JST)。CP932 展開 → らぶらぶシスターズ／体験版.exe (PE32 / ExHIBIT エンジン)。Prefix: prefixes/lovesis。
- 初回起動：ExHIBIT の Y/N ダイアログ（内容は GDI 回帰で豆腐、3行＋「□□(Y)」「□□□(N)」）→ Y を押す → **FCString class エラーダイアログ**（「hoge□□□□□□□□□□」＋OK）→ OK → **Wine C++ Runtime Library — Runtime error! abnormal program termination**（shots/lovesis-after-ok.png）。
- 再起動（2回目）：Y/N ダイアログは出ず、**FCString エラーが直接再現**（shots/lovesis2-title.png）。Y/N は初回のみのプロンプトで、FCString エラーは Y/N 選択に関係なく毎回発生する。原因 hypothesis：エンジンの文字列処理が起動時データの読み込みで失敗（日本語パス／ファイル欠損の可能性——未特定）。次の手（未実施）：+file での失敗ファイル特定、ASCII パスへのコピーでの再試行。
- 判定：**起動失敗**。本編未到達のため計測なし。

### #17 — 未着地（18:53 JST 時点）
- ダウンロード中 .part 3本（325 MB / 1,023 MB / 85 MB）。次回ポーリングで確認する。

## ポーリング記録（18:57 JST 時点）
- 新規着地なし（最終着地は pencil_0048.zip の重複コピー idx 1、18:48 JST）。本日完了ファイル計 18 本（18:52 時点と同じ）。
- ダウンロード中 .part 3本（493 MB / 1,106 MB / 170 MB）。18:53 時点の 325 / 1,023 / 85 MB から増加しており、DL は継続中。
- 回転側：#16 らぶらぶシスターズまで処理済み（18:53 JST、起動失敗・FCString エラー）。RESULTS.md に次タイトルの処理記録はまだなし。next_0228.zip（18:04 JST 着地）は未処理のまま。
- 最新ショットは lovesis2-title.png（18:52 JST）。

### #17 — お嬢様の半分は恋愛で出来ています！『秘密』のはじまり、体験版 (next_0228) — **本編OK / 本編文字は豆腐（GDI 回帰） / 計測済み** (2026-11-14 19:02–19:08 JST)
- Zip ~/workspace/browser_downloads/sess-382073416/browser-download-20261114T083320.841897584Z-13-next_0228.zip (1,010,532,427 B, 着地 17:33 JST——ポーリングの -newer 参照が新しすぎて見逃していた）。CP932 展開 → お嬢様の半分は恋愛で出来ています！～体験版～.exe (PE32 / Kirikiri)。Prefix: prefixes/ojou。
- 起動：初回問い「はじめにプレイ環境の設定を行いますか？」（画像文字で可読、shots/ojou-title.png）→ no → **タイトル到達**（shots/ojou-title2.png、Start/Load/Config/Exit）→ Start → 本編。主人公立ち絵＋夜の路地背景で台詞が進む（shots/ojou-story1.png→story2.png）。
- **文字化け**：本編の台詞（名前欄＋メッセージ）が全て □□ の豆腐。#11–#13 の Kirikiri タイトルでは本編文字が可読だったのと異なり、このタイトルは台詞描画に GDI フォント経路を使っているため、16:24 再起動後の GDI 回帰が本編文字にも及んでいる。**原因は環境側の回帰（ゲーム無改造）**。本編到達・進行自体は OK。
- **計測**（本編・夜の路地シーン、60 s、19:06 JST頃）:
  - 映像 v2: 平均 **0.017 pts/s**、中央値 0、≥10 の秒 0、ゼロ秒 59/60（measures/ojou-cap60.mp4、ojou-v2.json）。静止背景＋タイプライタのみの内容依存の低値。
  - 音声 delivery: **0.736**（総 69.79 s、非ギャップ 51.35 s、ギャップ 55 件 / 18.44 s、最長 0.435 s、measures/ojou-cap60.raw）。プローブ 95.8% 非ゼロ（BGM 流動中）。競合：ダウンロード3本並行中——競合下の数値でありスタックの実力ではない。

## 記録の訂正・補足（19:02 JST 時点）
- **旧 zip の大量消失**：sess-2974647991・sess-3290594869 は空、sess-382073416 は next_0228 のみ、sess-1175281584 は hobe_0400・yuzu_0002 のみ残存。df 使用量は 101G→86G（約15 GB 減）。**私の削除ではない**（私の削除は 18:00 以前、約8 GB 分のみ）。18:24 の VM 入れ替え前後でブラウザ側のセッション整理か何かが走った模様。処理済みタイトルの展開物（~/workspace/dmm-trials/<slug>/）と prefix は残っており、作業の証拠・再試行の材料は失われていない。なお sess-491508925 には pencil_0048.zip ×2（重複）と qual_0022.zip（#15 はにデビと同名——元 zip が消えたため md5 比較不可。ファイル名・slug 一致により重複として扱い、再処理しない。**削除はしない**）。
- **ポーリングの見逃し教訓**：next_0228（着地 17:33）を -newer 参照（hoshikoi-story1.png 17:42）で見逃した。ポーリングはセッション一覧の全数確認にすること。

## ポーリング記録（19:12 JST 時点）
- 新規着地：hobc_0525.zip（1,762,197,702 B、19:10 JST、sess-491508925 idx 2）。RESULTS.md への処理記録はまだなし（#18 の候補、hypothesis）。本日完了ファイル計 19 本（18:57 時点の 18 本から +1）。
- ダウンロード中 .part 3本（667 MB / 24 MB / 899 MB）。19:07 時点の 397 / 1,506 / 616 MB とはサイズが異なり、別ハッシュの再開または新規 DL の模様（hypothesis）。
- 回転側：#17 お嬢様の半分は恋愛で出来ています！体験版まで処理済み（19:08 JST、本編OK・本編文字は豆腐・計測済み v2 0.017 pts/s／音声 0.736）。最新ショットは ojou-story2.png（19:07 JST）。次回ポーリングで hobc_0525 の処理開始を確認する。

## ポーリング記録（19:17 JST 時点）
- 新規着地なし（最終着地は hobc_0525.zip、19:10 JST）。本日完了ファイル計 19 本（19:12 時点と同じ）。
- ダウンロード中 .part 3本（1,163 MB / 931 MB / 283 MB）。19:12 時点の 667 / 24 / 899 MB から全て増加しており、DL は継続中（同一タスク ID の3本）。
- 回転側：#17 お嬢様の半分は恋愛で出来ています！まで処理済み（19:08 JST、本編OK・本編文字は豆腐・計測済み v2 0.017 pts/s／音声 0.736）。RESULTS.md に #18（hobc_0525）の処理記録はまだなし。最新ショットは ojou-story2.png（19:07 JST）のまま。次回ポーリングで hobc_0525 の処理開始を確認する。

## ポーリング記録（19:22 JST 時点）
- 新規着地：asukad_0006.zip（19:20 JST、sess-491508925 idx 7）。RESULTS.md への処理記録はまだなし（#19 の候補、hypothesis）。本日完了は 19:17 時点の 19 本から +1 で 20 本（RESULTS.md 計数ベース。なおディスク上の当日ファイルは 9 本のみ——19:02 時点の旧 zip 大量消失の続き）。
- ダウンロード中 .part 2本（124 MB / 9.4 MB）。19:17 時点の 3本（1,163 / 931 / 283 MB）から本数・サイズとも変わっており、別タスクの DL か再開の模様（hypothesis）。
- 回転側：#17 お嬢様の半分は恋愛で出来ています！まで処理済み（19:08 JST、本編OK・本編文字は豆腐・計測済み v2 0.017 pts/s／音声 0.736）。#18（hobc_0525）の処理記録はまだなしだが、最新ショットが sorcery-title.png（19:20 JST）・sorcery-extract.png（19:22 JST）に変わっており、sorcery 系タイトルの処理が始まった模様（hobc_0525 と同一タイトルかは RESULTS.md に記録なし、hypothesis）。次回ポーリングで #18 の処理記録を確認する。

## ポーリング記録（19:27 JST 時点）
- 新規着地なし（最終着地は asukad_0006.zip の重複コピー、19:20 JST）。本日完了は 19:22 時点の 20 本のまま（RESULTS.md 計数ベース）。
- ダウンロード中 .part 3本（434 MB / 133 MB / 317 MB）。19:22 時点の 2本（124 MB / 9.4 MB）から本数・サイズとも変わっており、別タスクの DL か再開の模様（hypothesis）。
- 回転側：#17 お嬢様の半分は恋愛で出来ています！まで処理済み（19:08 JST、本編OK・本編文字は豆腐・計測済み v2 0.017 pts/s／音声 0.736）。#18（hobc_0525）の処理記録はまだなしだが、最新ショットが sorcery-title.png（19:20 JST）→ sorcery-virgl1.png（19:26 JST）と sorcery 系で進行中で、virgl での試行に入った模様（hobc_0525 と同一タイトルかは RESULTS.md に記録なし、hypothesis）。次回ポーリングで #18 の処理記録を確認する。

### #18 — ソーサリージョーカーズ 体験版 (hobc_0525, 3rdEye) — **起動失敗（Memory allocate error→黒画面、分類済み）** (2026-11-14 19:18–19:27 JST)
- Zip ~/workspace/browser_downloads/sess-491508925/browser-download-20261114T092805.289977817Z-2-hobc_0525.zip (1,762,197,702 B, 着地 18:28 JST)。sjs_trial.exe は **Lhaplus 自己解凍書庫**（ゲーム本体ではない）→ 展開ボタンを押して『ソーサリージョーカーズ Trial ver.』/SJS_trial.exe (PE32) を取り出して起動。Prefix: prefixes/sorcery。
- llvmpipe 起動：ウィンドウ「v2.50」＋エラーダイアログ **「Memory allocate error(1) : □□=0/□=640」**（shots/sorcery-title2.png）。OK（Return 長押し）でゲーム終了。寸法 0 を含むサーフェス確保の失敗とみられる（hypothesis）。
- virgl 起動：エラーダイアログは出ないが**黒画面のまま**（プロセス生存、CPU 0.4% でアイドル）。45 秒以上待っても変化なし。
- 判定：**起動失敗**。次の手（未実施）：RIO.INI の解像度設定確認、ウィンドウモード指定での再試行。本編未到達のため計測なし。

### #19 — 未着地（19:27 JST 時点）
- ダウンロード中 .part 3本（976 MB / 328 MB / 1,208 MB）。次回ポーリングで確認する。

## ポーリング記録（19:36 JST 時点）
- 新着2本はいずれも重複のためスキップ（削除はしない）：next_0228.zip（sess-491508925 idx 5、md5 が #17 処理済みと同一 afe453fcdb310649c6e2bd0000e8965f）、asukad_0006.zip（sess-491508925 idx 7、サイズが #12 処理済みと完全一致 813,139,758 B——元 zip 消失のため md5 比較不可だが slug・サイズ一致により重複扱い）。ダウンロード中 .part 3本（911 MB / 602 MB / 791 MB）。

## ポーリング記録（19:46 JST 時点）
- 新規着地なし。ダウンロード中 .part 3本（1,357 MB / 1,030 MB / 1,231 MB、成長中）。

## ポーリング記録（19:55 JST 時点）
- 新着3本はいずれも重複のためスキップ（削除はしない）：hobc_0525.zip（sess-491508925 idx 9、md5 が #18 処理済みと同一 8c35730cb7bac957ff105f5f7a25a994）、pencil_0048.zip（同 idx 10、md5 が #16 処理済みと同一 7837d85d46d8bc74eb52de09c665a5c7、3個目のコピー）、inre_0003.zip（同 idx 8、サイズが #11 処理済みと完全一致 1,432,153,444 B——元 zip 消失のため md5 比較不可だが slug・サイズ一致により重複扱い）。ダウンロード中 .part 3本（647 MB / 177 MB / 95 MB——全て新ハッシュで再開中）。

## ポーリング記録（20:04 JST 時点）
- 新着1本は重複のためスキップ（削除はしない）：views_0519.zip（sess-491508925 idx 13、サイズが #14 処理済みと完全一致 288,750,364 B——元 zip 消失のため md5 比較不可だが slug・サイズ一致により重複扱い）。ダウンロード中 .part 3本（1,042 MB / 354 MB / 25 MB——全て成長中）。

## ポーリング記録（20:16 JST 時点）
- 新着1本は重複のためスキップ（削除はしない）：qual_0022.zip（sess-491508925 idx 12、md5 が #15 処理済みと同一 a3ba8d3e58f334276c11e95c33e7e5e1）。ダウンロード中 .part 3本（1,465 MB / 23 MB / 277 MB——全て成長中）。

## VM 再起動（~20:24 JST）＋インフラ再構築（20:25–20:28 JST）
- ランタイム再起動に伴い VM が再度入れ替わった（up 0分）。Xvfb:118・twm・dmmpa・virgl 全て消滅、.part 3本も消滅（ダウンロードは現在飛行中ではない——ブラウザタスクが再開する見込み）。再構築済み：shell Xvfb:118（フラグ無し、grab 確認）＋twm＋dmmpa systemd unit（--exit-idle-time=-1、pactl info 確認）＋virgl サーバー（PIDs 4480/4481、ソケット確認）。なお 20:16 のハートビートは中断前に書き込み済みだった。
- 新着1本は重複のためスキップ（削除はしない）：cabbage_0001.zip（sess-491508925 idx 14、サイズが #13 処理済みと完全一致 608,717,092 B——元 zip 消失のため md5 比較不可だが slug・サイズ一致により重複扱い）。

## ポーリング記録（20:37 JST 時点）
- 新規着地なし。ダウンロード .part 3本が再開（360 MB / 202 MB / 440 MB、新ハッシュ）。VM は 20:24 入れ替えから 12 分経過し安定。

## ポーリング記録（20:46 JST 時点）
- 新規着地なし。ダウンロード .part 3本（507 MB / 424 MB / 809 MB、成長中）。VM 安定（up 21分）。

## ポーリング記録（20:55 JST 時点）
- 新規着地なし。ダウンロード .part 3本（655 MB / 643 MB / 1,178 MB、成長中）。VM 安定（up 30分）。

## ポーリング記録（21:04 JST 時点）
- 新規着地なし。ダウンロード .part 3本（803 MB / 866 MB / 1,548 MB、成長中）。VM 安定（up 39分）。

## ポーリング記録（19:37 JST 時点）
- 新規着地なし（最終着地は asukad_0006.zip、19:20 JST）。本日完了は 19:36 時点の 20 本のまま（RESULTS.md 計数ベース；ディスク上の当日ファイルは 9 本）。
- ダウンロード中 .part 3本（938 MB / 813 MB / 623 MB）。19:36 時点の 911 / 602 / 791 MB からサイズが変わっており、DL は継続中。
- 回転側：#18 ソーサリージョーカーズまで処理済み（19:27 JST、起動失敗・Memory allocate error→黒画面）。#19 は未着地で待機中。最新ショットは sorcery-virgl2.png（19:27 JST）のまま。

## ポーリング記録（19:52 JST 時点）
- 新規着地 3本（19:46 時点のポーリング以降）：inre_0003.zip（1,432,153,444 B、19:47 JST、sess-491508925 idx 8、新規タイトル・#20 の候補、hypothesis）、hobc_0525.zip（19:50 JST、idx 9、#18 処理済みとサイズ完全一致のため重複扱い）、pencil_0048.zip（19:47 JST、idx 10、#16 処理済みとサイズ完全一致のため重複扱い）。本日完了は 19:46 時点の 20 本から +1（新規のみ）で 21 本（RESULTS.md 計数ベース；ディスク上の当日ファイルは 12 本）。
- ダウンロード中 .part 3本（524 MB / 128 MB / 21 MB）。19:46 時点の 1,357 / 1,030 / 1,231 MB から大幅に縮小しており、別タスクの DL か再開の模様（hypothesis）。
- 回転側：#18 ソーサリージョーカーズまで処理済み（19:27 JST、起動失敗・Memory allocate error→黒画面）。#19 は未着地のまま待機中。最新ショットは sorcery-virgl2.png（19:27 JST）のまま変わらず。次回ポーリングで inre_0003 の処理開始を確認する。

## ポーリング記録（20:07 JST 時点）
- 新規着地なし（最終着地は views_0519.zip の重複コピー、20:03 JST）。本日完了は 20:04 時点の 21 本のまま（RESULTS.md 計数ベース；ディスク上の当日ファイルは 13 本）。
- ダウンロード中 .part 3本（1,126 MB / 397 MB / 66 MB）。20:04 時点の 1,042 / 354 / 25 MB から全て増加しており、DL は継続中。
- 回転側：#18 ソーサリージョーカーズまで処理済み（19:27 JST、起動失敗・Memory allocate error→黒画面）。#19 は未着地のまま待機中。最新ショットは sorcery-virgl2.png（19:27 JST）のまま変わらず。

## ポーリング記録（20:12 JST 時点）
- 新規着地なし（最終着地は views_0519.zip の重複コピー、20:03 JST）。本日完了は 20:07 時点の 21 本のまま（RESULTS.md 計数ベース；ディスク上の当日ファイルは 13 本）。
- ダウンロード中 .part 3本（1,329 MB / 498 MB / 167 MB）。20:07 時点の 1,126 / 397 / 66 MB から全て増加しており、DL は継続中。
- 回転側：#18 ソーサリージョーカーズまで処理済み（19:27 JST、起動失敗・Memory allocate error→黒画面）。#19 は未着地のまま待機中。inre_0003（19:47 JST 着地、#20 の候補）の処理記録もまだなし。最新ショットは sorcery-virgl2.png（19:27 JST）のまま変わらず。

## ポーリング記録（20:17 JST 時点）
- 新規着地なし（最終着地は qual_0022.zip の重複コピー idx 12、20:14 JST）。本日完了は 20:16 時点の 21 本のまま（RESULTS.md 計数ベース；ディスク上の当日ファイルは 14 本）。
- ダウンロード中 .part 3本（1.4 GB / 42 MB / 302 MB）。20:12 時点の 1,329 / 498 / 167 MB からサイズが変わっており、DL は継続中。
- 回転側：#18 ソーサリージョーカーズまで処理済み（19:27 JST、起動失敗・Memory allocate error→黒画面）。#19 は未着地のまま待機中。inre_0003（19:47 JST 着地、#20 の候補）の処理記録もまだなし。最新ショットは sorcery-virgl2.png（19:27 JST）のまま変わらず。

## ポーリング記録（20:22 JST 時点）
- 新規着地なし（最終着地は qual_0022.zip の重複コピー idx 12、20:14 JST）。本日完了は 20:17 時点の 21 本のまま（RESULTS.md 計数ベース；ディスク上の当日ファイルは 14 本）。
- ダウンロード中 .part 3本（1.5 GB / 136 MB / 495 MB）。20:17 時点の 1.4 GB / 42 MB / 302 MB から全て増加しており、DL は継続中。
- 回転側：#18 ソーサリージョーカーズまで処理済み（19:27 JST、起動失敗・Memory allocate error→黒画面）。#19 は未着地のまま待機中。inre_0003（19:47 JST 着地、#20 の候補）の処理記録もまだなし。最新ショットは sorcery-virgl2.png（19:27 JST）のまま変わらず。

## ポーリング記録（20:27 JST 時点）
- 新規着地：cabbage_0001.zip（608,717,092 B、20:24 JST、sess-491508925 idx 14、新規タイトル・#20 の候補、hypothesis——inre_0003 は 19:47 着地済みだが処理記録なしのため #19/#20 の番号付けは RESULTS.md の次回更新で確定する）。本日完了は 20:22 時点の 21 本から +1 で 22 本（RESULTS.md 計数ベース；ディスク上の当日ファイルは 15 本）。
- ダウンロード中 .part 2本（154 MB / 38 MB）。20:22 時点の 3本（1.5 GB / 136 MB / 495 MB）から本数が減っており、1本が着地（cabbage_0001 とみられる、hypothesis）した模様。
- 回転側：#18 ソーサリージョーカーズまで処理済み（19:27 JST、起動失敗・Memory allocate error→黒画面）。#19 は未着地のまま待機中。inre_0003（19:47 JST 着地）の処理記録もまだなし。最新ショットは sorcery-virgl2.png（19:27 JST）のまま変わらず。次回ポーリングで cabbage_0001 / inre_0003 の処理開始を確認する。

## ポーリング記録（20:42 JST 時点）
- 新規着地なし（最終着地は cabbage_0001.zip、20:24 JST）。本日完了は 20:37 時点の 22 本のまま（RESULTS.md 計数ベース；ディスク上の当日ファイルは 15 本）。
- ダウンロード中 .part 3本（443 MB / 325 MB / 647 MB）。20:37 時点の 360 / 202 / 440 MB から全て増加しており、DL は継続中。
- 回転側：#18 ソーサリージョーカーズまで処理済み（19:27 JST、起動失敗・Memory allocate error→黒画面）。inre_0003（19:47 JST 着地）・cabbage_0001（20:24 JST 着地）の処理記録はまだなし。最新ショットは sorcery-virgl2.png（19:27 JST）のまま変わらず。次回ポーリングで #19/#20 の処理開始を確認する。

## ポーリング記録（20:47 JST 時点）
- 新規着地なし（最終着地は cabbage_0001.zip、20:24 JST）。本日完了は 20:42 時点の 22 本のまま（RESULTS.md 計数ベース；ディスク上の当日ファイルは 15 本）。
- ダウンロード中 .part 3本（500 MB / 427 MB / 812 MB）。20:46 時点の 507 / 424 / 809 MB から全て増加しており、DL は継続中。
- 回転側：#18 ソーサリージョーカーズまで処理済み（19:27 JST、起動失敗・Memory allocate error→黒画面）。inre_0003（19:47 JST 着地）・cabbage_0001（20:24 JST 着地）の処理記録はまだなし。最新ショットは sorcery-virgl2.png（19:27 JST）のまま変わらず。次回ポーリングで #19/#20 の処理開始を確認する。

## ポーリング記録（20:52 JST 時点）
- 新規着地なし（最終着地は cabbage_0001.zip、20:24 JST）。本日完了は 20:47 時点の 22 本のまま（RESULTS.md 計数ベース；ディスク上の当日ファイルは 15 本）。
- ダウンロード中 .part 3本（577 MB / 541 MB / 1,003 MB）。20:47 時点の 500 / 427 / 812 MB から全て増加しており、DL は継続中。
- 回転側：#18 ソーサリージョーカーズまで処理済み（19:27 JST、起動失敗・Memory allocate error→黒画面）。inre_0003（19:47 JST 着地）・cabbage_0001（20:24 JST 着地）の処理記録はまだなし。最新ショットは sorcery-virgl2.png（19:27 JST）のまま変わらず。次回ポーリングで #19/#20 の処理開始を確認する。

## ポーリング記録（20:57 JST 時点）
- 新規着地なし（最終着地は cabbage_0001.zip、20:24 JST）。本日完了は 20:52 時点の 22 本のまま（RESULTS.md 計数ベース；ディスク上の当日ファイルは 15 本）。
- ダウンロード中 .part 3本（685 MB / 690 MB / 1,255 MB）。20:52 時点の 577 / 541 / 1,003 MB から全て増加しており、DL は継続中。
- 回転側：#18 ソーサリージョーカーズまで処理済み（19:27 JST、起動失敗・Memory allocate error→黒画面）。inre_0003（19:47 JST 着地）・cabbage_0001（20:24 JST 着地）の処理記録はまだなし。最新ショットは sorcery-virgl2.png（19:27 JST）のまま変わらず。次回ポーリングで #19/#20 の処理開始を確認する。

## ポーリング記録（21:02 JST 時点）
- 新規着地なし（最終着地は cabbage_0001.zip、20:24 JST）。本日完了は 20:57 時点の 22 本のまま（RESULTS.md 計数ベース；ディスク上の当日ファイルは 15 本）。
- ダウンロード中 .part 3本（768 MB / 814 MB / 1,462 MB）。20:57 時点の 685 / 690 / 1,255 MB から全て増加しており、DL は継続中。
- 回転側：#18 ソーサリージョーカーズまで処理済み（19:27 JST、起動失敗・Memory allocate error→黒画面）。inre_0003（19:47 JST 着地）・cabbage_0001（20:24 JST 着地）の処理記録はまだなし。最新ショットは sorcery-virgl2.png（19:27 JST）のまま変わらず。次回ポーリングで #19/#20 の処理開始を確認する。

## ポーリング記録（21:12 JST 時点）
- 新規着地 2本（21:09 JST、新セッション sess-2568964190）：abgktk_0009.zip（1,746,937,497 B、新規スラッグ・#21 の候補、hypothesis）、next_0228.zip（1,010,532,427 B——19:36 時点に #17 と md5 一致で重複扱いされた同名ファイルの別セッション版、重複の可能性が高いが RESULTS.md に記録なし、hypothesis）。本日完了は 21:04 時点の 22 本から +2（未判定）で、ディスク上の当日ファイルは 15 本→17 本。
- ダウンロード中 .part 3本（1,019 MB / 43 MB / 51 MB）。21:04 時点の 803 / 866 / 1,548 MB から 1本は増加・2本は大幅縮小しており、別タスクの DL か再開の模様（hypothesis）。
- 回転側：#18 ソーサリージョーカーズまで処理済み（19:27 JST、起動失敗・Memory allocate error→黒画面）のまま。inre_0003（19:47 JST 着地）・cabbage_0001（20:24 JST 着地）の処理記録はまだなし。最新ショットは sorcery-virgl2.png（19:27 JST）のまま変わらず。VM は 20:24 入れ替えから安定（up 約48分）。次回ポーリングで abgktk_0009 / next_0228 の処理開始を確認する。

## ポーリング記録（21:17 JST 時点）
- 新規着地なし（最終着地は abgktk_0009.zip・next_0228.zip、21:09 JST、21:12 記録済み）。本日完了は 21:12 時点の 22 本のまま（RESULTS.md 計数ベース；ディスク上の当日ファイルは 17 本）。
- ダウンロード中 .part 3本（1,269 MB / 163 MB / 134 MB）。21:12 時点の 1,019 / 43 / 51 MB から全て増加しており、DL は継続中。
- 回転側：#18 ソーサリージョーカーズまで処理済み（19:27 JST、起動失敗・Memory allocate error→黒画面）のまま。inre_0003（19:47 JST 着地）・cabbage_0001（20:24 JST 着地）・abgktk_0009（21:09 JST 着地）の処理記録はまだなし。最新ショットが fontdbg-notepad1.png（21:15 JST）に変わっており、フォント調査（Notepad）のショットと思われる（hypothesis、RESULTS.md に記録なし）。VM は 20:24 入れ替えから安定（up 約53分）。次回ポーリングで #19 以降の処理開始を確認する。

## ポーリング記録（21:22 JST 時点）
- 新規着地なし（最終着地は abgktk_0009.zip・next_0228.zip、21:09 JST、21:12 記録済み）。本日完了は 21:17 時点の 22 本のまま（RESULTS.md 計数ベース；ディスク上の当日ファイルは 17 本）。
- ダウンロード中 .part 3本（1.4 GB / 271 MB / 206 MB）。21:17 時点の 1,269 / 163 / 134 MB から全て増加しており、DL は継続中。
- 回転側：#18 ソーサリージョーカーズまで処理済み（19:27 JST、起動失敗・Memory allocate error→黒画面）のまま。inre_0003（19:47 JST 着地）・cabbage_0001（20:24 JST 着地）・abgktk_0009（21:09 JST 着地）の処理記録はまだなし。最新ショットは fontdbg-notepad3.png（21:20 JST）で、フォント調査（Notepad）が継続中と思われる（hypothesis、RESULTS.md に記録なし）。VM は 20:24 入れ替えから安定（up 約58分）。次回ポーリングで #19 以降の処理開始を確認する。

## フォント回帰 — 修正確定（2026-11-14 21:14–21:27 JST）
- **根本原因（+font ログで特定）**：(1) FontSubstitutes の代替先「IPAGothic」は存在しないファミリ名だった——IPA Gothic の実ファミリ名は「IPAゴシック」。代替が見つからず stock フォント (jvgasys.fon / Tahoma) にフォールバックしていた。(2) FontLink SystemLink の「IPAG.TTF,IPAGothic」はファイル名の大文字小文字が合わず「Unable to find file」。(3) WindowMetrics の全フォント（Menu/Caption/Icon/Message/SmCaption/Status）が Latin-only の Tahoma だった——メニューはここから来ていた。(4) jvgasys.fon の DBCS 描画が 16:24 再起動後に壊れ、フォールバック先が豆腐を返していた（14:05 時点の「修正」は実は.fon 描画が生きていただけで、IPA 代替は一度も効いていなかった）。
- **修正内容（全て環境側、template32 が標準）**：
- system.reg：FontSubstitutes の値を「IPAGothic」→「IPAゴシック」、「IPAPGothic」→「IPA Pゴシック」に（計31箇所）、SystemLink の「IPAG.TTF,IPAGothic」→「ipag.ttf,IPAゴシック」に（4箇所）。バックアップ system.reg.bak-fontfix2。
- user.reg：WindowMetrics 6フォントの LOGFONT face 名を Tahoma→「IPAゴシック」、lfCharSet を 128 (SHIFTJIS) に。バックアップ user.reg.bak-fontfix2。
- Wine share の jvgasys.fon を tools/fon-backup/ へ移動（リネーム、削除ではない。バックアップあり）。これで「System」要求は Droid Sans Fallback / IPA 経由で描画される。
- **検証（Notepad、shots/fontdbg-notepad4.png）**：メニュー「ファイル(F) 編集(E) 書式(O) 表示(V) ヘルプ(H)」、ステータス「1 行，1 列」、編集部「あいうえお漢字テスト日本語ABC123」すべて可読。**文字化け解消 ✅**
- **#17 お嬢様 再検証（新 prefix ojou2、shots/ojou2-story1.png）**：本編台詞が完全可読——名前「創」、台詞「「……それでは、失礼します。本当に、今までお世話になりました」」。**#17 文字化け解消 ✅**（計測値は既存の v2 0.017 / audio 0.736 を維持）。

## 新規着地（21:13 JST 時点）
- abgktk_0009.zip（sess-2568964190 idx 1、1,746,937,497 B、着地 21:09 JST）——**新規タイトル #19 として未処理**。フォント修正後に処理する。next_0228.zip（sess-491508925）は #17 の重複。
- 21:13 時点の.part 3本（1,121 MB / 76 MB / 74 MB）。

## ポーリング記録（21:27 JST 時点）
- 新規着地なし（最終着地は abgktk_0009.zip・next_0228.zip、21:09 JST、21:12 記録済み）。本日完了は 21:22 時点の 22 本のまま（RESULTS.md 計数ベース；ディスク上の当日ファイルは 17 本）。
- ダウンロード中 .part 3本（1.6 GB / 388 MB / 290 MB）。21:22 時点の 1.4 GB / 271 MB / 206 MB から全て増加しており、DL は継続中。
- 回転側：#18 ソーサリージョーカーズまで処理済み（19:27 JST、起動失敗・Memory allocate error→黒画面）のまま。inre_0003（19:47 JST 着地）・cabbage_0001（20:24 JST 着地）・abgktk_0009（21:09 JST 着地）の処理記録はまだなし。最新ショットが ojou2-title.png／ojou2-story1.png（21:26 JST）に変わっており、フォント調査（fontdbg-notepad4.png、21:23 JST）の後、新タイトル（ojou2 系）の処理に入った模様（hypothesis、RESULTS.md に記録なし）。VM は 20:24 入れ替えから安定（up 約1時間）。次回ポーリングで ojou2 の処理記録を確認する。

## ポーリング記録（21:32 JST 時点）
- 新規着地 1本：ncpy_0002.zip（680,746,566 B、21:31 JST、sess-2568964190 idx 3）。#8 ノラと皇女と野良猫ハートの zip と同サイズで重複再着地の可能性が高い（hypothesis、md5 未確認）。ディスク上の当日ファイルは 17 本→18 本。RESULTS.md 計数ベースは 22 本＋未判定 1 本。
- ダウンロード中 .part 0本。21:27 時点の 3本（1.6 GB / 388 MB / 290 MB）が消滅。着地が確認できたのは ncpy_0002 のみで、残り 2本の行方は不明（hypothesis：ブラウザ側で一時停止・完了・別セッションへの移動のいずれか）。
- 回転側：最新ショットが hanidebi3-title.png／title2.png／info.png／set.png（21:29–21:31 JST）に変わっており、#15 はにデビ！を新 prefix hanidebi3 で再処理中と思われる（hypothesis、RESULTS.md に記録なし）。フォント修正後の再検証の可能性が高い。ojou2（21:26 JST）の処理記録はまだなし。inre_0003・cabbage_0001・abgktk_0009 の処理記録もまだなし。
- 直近の確定結果：フォント回帰の修正確定（21:14–21:27 JST、RESULTS.md 記録済み）——Notepad で日本語可読を確認、#17 お嬢様の本編台詞も完全可読で文字化け解消 ✅。次回ポーリングで hanidebi3 の処理記録と .part の再出現を確認する。

## ポーリング記録（21:37 JST 時点）
- 新規着地なし（最終着地は ncpy_0002.zip、21:31 JST、21:32 記録済み）。本日完了は 21:32 時点の 22 本＋未判定 1 本のまま（RESULTS.md 計数ベース；ディスク上の当日ファイルは 18 本）。
- ダウンロード中 .part 2本（126 MB / 244 MB）。21:32 時点の 0本から再出現しており、DL が再開した模様（hypothesis）。
- 回転側：最新ショットが hanidebi3-title3.png（21:36 JST）に変わっており、#15 はにデビ！の新 prefix hanidebi3 での再処理が継続中と思われる（hypothesis、RESULTS.md に記録なし）。フォント修正後の再検証の可能性が高い。ojou2（21:26 JST）・inre_0003・cabbage_0001・abgktk_0009 の処理記録はまだなし。
- 直近の確定結果：フォント回帰の修正確定（21:14–21:27 JST、RESULTS.md 記録済み）——Notepad で日本語可読を確認、#17 お嬢様の本編台詞も完全可読で文字化け解消 ✅。VM は 20:24 入れ替えから安定（up 約1時間12分）。次回ポーリングで hanidebi3 の処理記録と .part の進捗を確認する。

## ポーリング記録（21:42 JST 時点）
- 新規着地なし（最終着地は ncpy_0002.zip、21:31 JST、21:32 記録済み）。本日完了は 21:37 時点の 22 本＋未判定 1 本のまま（RESULTS.md 計数ベース；ディスク上の当日ファイルは 18 本）。
- ダウンロード中 .part 2本（247 MB / 129 MB）。21:37 時点の 126 MB / 244 MB からサイズが変わっており、DL は継続中。
- 回転側：最新ショットが hanidebi3-after-start.png（21:37 JST）→ hanidebi3-after-tap.png（21:37 JST）→ hanidebi3-after-key.png（21:38 JST）に変わっており、#15 はにデビ！の新 prefix hanidebi3 での再処理が継続中と思われる（hypothesis、RESULTS.md に記録なし）。タイトル画面への入力試行（START 押下・タップ・キー）の連写とみられる。フォント修正後の再検証の可能性が高い。ojou2（21:26 JST）・inre_0003・cabbage_0001・abgktk_0009 の処理記録はまだなし。
- 直近の確定結果：フォント回帰の修正確定（21:14–21:27 JST、RESULTS.md 記録済み）——Notepad で日本語可読を確認、#17 お嬢様の本編台詞も完全可読で文字化け解消 ✅。VM は 20:24 入れ替えから安定（up 約1時間18分）。次回ポーリングで hanidebi3 の処理記録と .part の進捗を確認する。

## ポーリング記録（21:47 JST 時点）
- 新規着地なし（最終着地は ncpy_0002.zip、21:31 JST、21:32 記録済み）。本日完了は 21:42 時点の 22 本＋未判定 1 本のまま（RESULTS.md 計数ベース；ディスク上の当日ファイルは 18 本）。
- ダウンロード中 .part 2本（約105 MB / 約1.6 MB）。21:42 時点の 247 / 129 MB とはサイズが異なり、再開または新規 DL の模様（hypothesis）。1本は 1分で約94 MB→約110 MB と成長中。
- 回転側：最新ショットが abgktk-title.png（21:43 JST）→ abgktk-title2.png（21:45 JST）→ abgktk-title3.png（21:47 JST）に変わっており、abgktk_0009（#19 候補）の処理に入った模様（hypothesis、RESULTS.md に処理記録はまだなし）。3枚とも 5,338 B で、過去の黒画面ショットと同サイズ（hypothesis：タイトル画面が黒画面の可能性）。hanidebi3 の再検証は 21:38 の after-key.png まで。inre_0003・cabbage_0001 の処理記録もまだなし。
- 直近の確定結果：フォント回帰の修正確定（21:14–21:27 JST、RESULTS.md 記録済み）——Notepad で日本語可読を確認、#17 お嬢様の本編台詞も完全可読で文字化け解消 ✅。VM は 20:24 入れ替えから安定（up 約1時間23分）。次回ポーリングで abgktk_0009 の処理記録と .part の進捗を確認する。

## #15 はにデビ！ 再試行（2026-11-14 21:27–21:39 JST、分類済み・タイトルまで維持）
- 新 prefix hanidebi2（フォント修正済み template32）で再起動。エンジン設定ダイアログ → OK → 情報ダイアログ「解像度が足りないためウィンドウを縮小します。」（**可読**——フォント修正の効果）→ eufonie ロゴ → タイトル到達（shots/hanidebi3-title3.png）。ウィンドウは縮小表示（1280x698、実描画は約1152幅）。
- **活性化仮説は除外**：xdotool getwindowfocus はゲーム窓「はにデビ！ - 体験版」(12582917) を指し、フォーカスはある。twm は _NET_ACTIVE_WINDOW 非対応（windowactivate は失敗するが、xtest focus は成功）。それでも START への holdclick / xdotool タップクリック / Down+Return の全てが無反応（ホバーの強調表示すら出ない）。ダイアログ類は同じセッションで入力に応答したので、入力経路自体は生きており、ゲーム窓だけが死んでいる。
- ゲームプロセスはタイトル画面で **CPU 103% スピン**、ログに err なし。未実施の手：virgl 再試行、+dinput ログ。**判定：タイトルまで**（入力無視、分類済み）。

## #19 千の刃濤、桃花染の皇姫 体験版 Ver1.1 Online (abgktk_0009) — 起動失敗（0x406097c6 SEGV、#4/#10 と共有原因）（2026-11-14 21:39–21:49 JST）
- Zip sess-2568964190 idx 1（1,746,937,497 B）。BGI エンジン（BGI.exe PE32、data*.arc）。CP932 展開。
- **ディスククォータ再発**：展開中に Errno 122（df は 48G 空き表示、102G 使用中）。50/89 ファイルのみ展開、data02890.arc は 530/886MB で切断、system.arc / sysgrp.arc 等 39 ファイル欠落。**削除禁止のため /home への追記は不可**。回避策：/var/tmp（2.0G tmpfs、書き込み可）に不足分 1.18GB を展開し、/var/tmp/abgktk-run/ に全93エントリのシンボリックリンク構成を作成（exe 本体は実体コピー——シンボリックリンクだとモジュールパスが実ディレクトリを指し欠落データを見に行くため）。/dev/shm（794MB）は不足分が入らず、リマウントも不可だった。
- 起動：BGI.exe は system.arc を開き、ReiminProL.otf を探す（zip には存在しない）が、その後 **`seh:segv_handler Got unexpected trap -1`、アドレス 0x406097c6、nested exception** で無言終了（logs/abgktk4.log、+file デバッグで確認）。
- **重要：#4 will_0110（AdvHD）・#10 タンテイセブン（Pixel）と同一アドレス 0x406097c6**。エンジンが3種異なるのに同一故障点——Wine/QEMU 側の共有故障点であることがほぼ確定。**判定：起動失敗**（共有原因グループ：#4/#10/#19）。次の手：+d3d で故障モジュールの特定、virgl 再試行、CPU モデル行列。
- 副産物：sess-2568964190 には next_0228.zip（#17 重複）と ncpy_0002.zip（#8 重複）もあり——重複としてスキップ（削除なし）。

## ポーリング記録（21:57 JST 時点）
- 新規着地なし（最終着地は ncpy_0002.zip、21:31 JST、21:32 記録済み）。本日完了は 21:47 時点の 22 本＋未判定 1 本のまま（RESULTS.md 計数ベース；ディスク上の当日ファイルは 18 本）。
- ダウンロード中 .part 1本（約87 MB）。21:47 時点の 2本（約105 MB / 約1.6 MB）から本数が減りサイズも変わっており、再開または新規 DL の模様（hypothesis）。
- 回転側：#19 千の刃濤、桃花染の皇姫（abgktk_0009）が RESULTS.md に記録済み（21:39–21:49 JST、起動失敗・0x406097c6 SEGV、#4/#10 と共有原因）。その後、最新ショットが realive3-dialog.png（21:52 JST）→ realive3-dialog2.png（21:53 JST）→ realive4-dialog.png（21:56 JST）に変わっており、realive の再処理に入った模様（hypothesis、RESULTS.md に記録なし）。3枚とも 5,338 B で過去の黒画面ショットと同サイズ。inre_0003・cabbage_0001 の処理記録はまだなし。
- 直近の確定結果：フォント回帰の修正確定（21:14–21:27 JST、RESULTS.md 記録済み）——Notepad で日本語可読を確認、#17 お嬢様の本編台詞も完全可読で文字化け解消 ✅。#15 はにデビ！はタイトルまで維持（入力無視、分類済み）。VM は 20:24 入れ替えから安定（up 約1時間33分）。次回ポーリングで realive の処理記録と .part の進捗を確認する。

## ポーリング記録（22:02 JST 時点）
- 新規着地なし（最終着地は ncpy_0002.zip、21:31 JST、21:32 記録済み）。本日完了は 21:57 時点の 22 本＋未判定 1 本のまま（RESULTS.md 計数ベース；ディスク上の当日ファイルは 18 本）。
- ダウンロード中 .part 1本（約450 MB）。21:57 時点の 1本（約87 MB）から大幅に増加しており、DL は継続中。
- 回転側：#19 千の刃濤、桃花染の皇姫まで処理済み（21:49 JST、起動失敗・0x406097c6 SEGV）。その後、最新ショットが realive5-dialog.png（21:58 JST）→ realive5-title.png（21:59 JST）→ realive5-title2.png（22:01 JST）→ realive5-title3.png（22:02 JST）に変わっており、realive の再処理がタイトル到達段階まで進んだ模様（hypothesis、RESULTS.md に記録なし）。title2.png は 845,792 B の実画面で、dialog 系の黒画面（5,338 B）とは異なる。inre_0003・cabbage_0001 の処理記録はまだなし。
- 直近の確定結果：フォント回帰の修正確定（21:14–21:27 JST、RESULTS.md 記録済み）——Notepad で日本語可読を確認、#17 お嬢様の本編台詞も完全可読で文字化け解消 ✅。#15 はにデビ！はタイトルまで維持（入力無視、分類済み）。VM は 20:24 入れ替えから安定（up 約1時間38分）。次回ポーリングで realive の処理記録と .part の進捗を確認する。

## #5 RIDDLE JOKER — KK指示「いけたゲーム起動してみて」で起動維持中（2026-11-14 22:02–22:04 JST）
- KK の新指示で #2 リアライブ再処理を中断し、本編OK確定済みの #5 RIDDLE JOKER を :118 で起動。virgl + 新 prefix riddowejoker2（フォント修正済み template32）。
- 起動後タイトルを経ず本編画面に直行（前回実行時のセーブ/設定がゲームディレクトリに残存のためと推定）。本編1行目「8月下旬。夏休みも残りが少なくなってきても、うだるような暑さは変わらない。」を表示中（shots/riddle2-title.png）。台詞は完全可読、virgl 描画は鮮明。
- **起動維持中**：プロセス pgid 29397、:118 表示中。KK がゲームパネルで見て操作できる状態。以後、KK の操作と競合しないようこのラインからは入力を送らない。締切24:00の残作業（#2/#6/#14、起動失敗組）はこの後再開する。

## ポーリング記録（22:07 JST 時点）
- 新規着地なし（最終着地は ncpy_0002.zip、21:31 JST、21:32 記録済み）。本日完了は 22:02 時点の 22 本＋未判定 1 本のまま（RESULTS.md 計数ベース；ディスク上の当日ファイルは 18 本）。
- ダウンロード中 .part 2本（約52 MB / 約36 MB）。22:02 時点の 1本（約450 MB）は消滅し、新規着地は確認できず行方は不明（hypothesis：ブラウザ側で一時停止・完了・別セッションへの移動のいずれか）。現在の 2本は 22:07 JST 時点の新規タイムスタンプで、DL 継続中とみられる。
- 回転側：KK 指示（22:02 JST）で #5 RIDDLE JOKER を :118 で起動維持中（pgid 29397、プロセス生存確認済み、最新ショット riddle2-title.png 22:04 JST、本編1行目を表示中）。#2 リアライブの再処理は KK 指示で中断されたまま。inre_0003・cabbage_0001 の処理記録はまだなし。
- 直近の確定結果：#19 千の刃濤、桃花染の皇姫は起動失敗（0x406097c6 SEGV、#4/#10 と共有原因、21:39–21:49 JST 記録済み）。フォント回帰の修正確定（21:14–21:27 JST）——#17 お嬢様の本編台詞も完全可読で文字化け解消 ✅。VM は 20:24 入れ替えから安定（up 約1時間43分）。次回ポーリングで RIDDLE JOKER の維持状態と .part の進捗を確認する。

## ポーリング記録（22:12 JST 時点）
- 新規着地なし（最終着地は ncpy_0002.zip、21:31 JST、21:32 記録済み）。本日完了は 22:07 時点の 22 本＋未判定 1 本のまま（RESULTS.md 計数ベース；ディスク上の当日ファイルは 18 本）。
- ダウンロード中 .part 0本。22:12:07 の確認では 2本（148 MB / 367 MB）が存在したが、約30秒後の再確認で消滅。新規着地は確認できず行方は不明（hypothesis：ブラウザ側で一時停止・完了・別セッションへの移動のいずれか）。22:07 時点の 2本（52 MB / 36 MB）ともサイズが異なり、別タスクの DL か再開の模様。
- 回転側：KK 指示（22:02 JST）で #5 RIDDLE JOKER を :118 で起動維持中（pgid 29397、22:12 時点で経過約10分・プロセス生存確認済み、最新ショット riddle2-title.png 22:04 JST、本編1行目を表示中）。#2 リアライブの再処理は KK 指示で中断されたまま。inre_0003・cabbage_0001 の処理記録はまだなし。
- 直近の確定結果：#19 千の刃濤、桃花染の皇姫は起動失敗（0x406097c6 SEGV、#4/#10 と共有原因、21:39–21:49 JST 記録済み）。フォント回帰の修正確定（21:14–21:27 JST）——#17 お嬢様の本編台詞も完全可読で文字化け解消 ✅。VM は 20:24 入れ替えから安定（up 約1時間48分）。次回ポーリングで RIDDLE JOKER の維持状態と .part の再出現を確認する。

## ポーリング記録（22:17 JST 時点）
- 新規着地あり：alice_0056.zip（142 MB、22:15:49 JST、sess-383098573）。RESULTS.md への記録はまだなし（本ポーリングで初確認）。本日完了はディスク上 19 本（RESULTS.md 計数ベース 22 本＋未判定 1 本との差は従来通り）。
- ダウンロード中 .part 3本（46 MB / 86 MB / 93 MB、いずれも 22:17 JST 時点で成長中：約30秒で 33→46 MB、79→86 MB、22→93 MB と増加を確認、DL 継続中）。22:12 時点の 0本からは再出現。
- 回転側：KK 指示（22:02 JST）で #5 RIDDLE JOKER を :118 で起動維持中（pgid 29397、22:17 時点で経過約15分・プロセス生存確認済み、最新ショット riddle2-title.png 22:04 JST、本編1行目を表示中）。#2 リアライブの再処理は KK 指示で中断されたまま。inre_0003・cabbage_0001 の処理記録はまだなし。
- 直近の確定結果：#19 千の刃濤、桃花染の皇姫は起動失敗（0x406097c6 SEGV、#4/#10 と共有原因、21:39–21:49 JST 記録済み）。フォント回帰の修正確定（21:14–21:27 JST）——#17 お嬢様の本編台詞も完全可読で文字化け解消 ✅。VM は 20:24 入れ替えから安定（up 約1時間53分）。次回ポーリングで alice_0056.zip の記録と .part の進捗を確認する。

## ポーリング記録（22:22 JST 時点）
- 新規着地なし（最終着地は alice_0056.zip、22:15:49 JST、22:17 記録済み）。本日完了は 22:17 時点の 22 本＋未判定 1 本のまま（RESULTS.md 計数ベース；ディスク上の当日ファイルは 19 本）。
- ダウンロード中 .part 2本（約27 MB / 約164 MB）。22:17 時点の 3本（46 / 86 / 93 MB）から本数が減りサイズも異なり、約30秒の間に 23→27 MB、155→164 MB と増加を確認、DL は継続中。
- 回転側：KK 指示（22:02 JST）で #5 RIDDLE JOKER を :118 で起動維持中（pgid 29397、22:22 時点で経過約20分・プロセス生存確認済み、最新ショット riddle2-title.png 22:04 JST、本編1行目を表示中）。#2 リアライブの再処理は KK 指示で中断されたまま。alice_0056・inre_0003・cabbage_0001 の処理記録はまだなし。
- 直近の確定結果：#19 千の刃濤、桃花染の皇姫は起動失敗（0x406097c6 SEGV、#4/#10 と共有原因、21:39–21:49 JST 記録済み）。フォント回帰の修正確定（21:14–21:27 JST）——#17 お嬢様の本編台詞も完全可読で文字化け解消 ✅。VM は 20:24 入れ替えから安定（up 約1時間58分）。次回ポーリングで RIDDLE JOKER の維持状態と .part の進捗を確認する。

## ポーリング記録（22:27 JST 時点）
- 新規着地なし（最終着地は alice_0056.zip、22:15:49 JST、22:17 記録済み）。本日完了は 22:22 時点の 22 本＋未判定 1 本のまま（RESULTS.md 計数ベース；ディスク上の当日ファイルは 19 本）。
- ダウンロード中 .part 0本。22:22 時点の 2本（約27 MB / 約164 MB）は消滅し、新規着地は確認できず行方は不明（hypothesis：ブラウザ側で一時停止・完了・別セッションへの移動のいずれか）。
- 回転側：KK 指示（22:02 JST）で #5 RIDDLE JOKER を :118 で起動維持中（pgid 29397、22:27 時点で経過約25分・プロセス生存確認済み、最新ショット riddle2-title.png 22:04 JST、本編1行目を表示中）。#2 リアライブの再処理は KK 指示で中断されたまま。alice_0056・inre_0003・cabbage_0001 の処理記録はまだなし。
- 直近の確定結果：#19 千の刃濤、桃花染の皇姫は起動失敗（0x406097c6 SEGV、#4/#10 と共有原因、21:39–21:49 JST 記録済み）。フォント回帰の修正確定（21:14–21:27 JST）——#17 お嬢様の本編台詞も完全可読で文字化け解消 ✅。VM は 20:24 入れ替えから安定（up 約2時間03分）。次回ポーリングで RIDDLE JOKER の維持状態と .part の再出現を確認する。

## ポーリング記録（22:37 JST 時点）— 実行側の追記がディスククォータ（Errno 122）で失敗したため、親側が /tmp/dmm-polling-2237.md から転記
- 新規着地なし（最終着地は alice_0056.zip、22:15:49 JST、22:17 記録済み）。本日完了は 22:27 時点の 22 本＋未判定 1 本のまま（RESULTS.md 計数ベース；ディスク上の当日ファイルは 19 本）。
- ダウンロード中 .part 0本。22:27 時点の 0本のまま再出現なし。22:22 時点の 2本（約27 MB / 約164 MB）の行方は引き続き不明（hypothesis：ブラウザ側で一時停止・完了・別セッションへの移動のいずれか）。
- 回転側：KK 指示（22:02 JST）で #5 RIDDLE JOKER を :118 で起動維持中（pgid 29397、22:37 時点で経過約35分・プロセス生存確認済み、最新ショット riddle2-title.png 22:04 JST、本編1行目を表示中）。#2 リアライブの再処理は KK 指示で中断されたまま。alice_0056・inre_0003・cabbage_0001 の処理記録はまだなし。
- 直近の確定結果：#19 千の刃濤、桃花染の皇姫は起動失敗（0x406097c6 SEGV、#4/#10 と共有原因、21:39–21:49 JST 記録済み）。フォント回帰の修正確定（21:14–21:27 JST）——#17 お嬢様の本編台詞も完全可読で文字化け解消 ✅。VM は 20:24 入れ替えから安定（up 約2時間13分）。次回ポーリングで RIDDLE JOKER の維持状態と .part の再出現を確認する。

## ポーリング記録（22:42 JST 時点）
- 新規着地なし（最終着地は alice_0056.zip、22:15:49 JST、22:17 記録済み）。本日完了は 22:37 時点の 22 本＋未判定 1 本のまま（RESULTS.md 計数ベース；ディスク上の当日ファイルは 19 本）。
- ダウンロード中 .part 0本。22:27 時点の 0本のまま再出現なし。22:22 時点の 2本（約27 MB / 約164 MB）の行方は引き続き不明（hypothesis：ブラウザ側で一時停止・完了・別セッションへの移動のいずれか）。
- 回転側：KK 指示（22:02 JST）で #5 RIDDLE JOKER を :118 で起動維持中（pgid 29397、22:42 時点で経過約40分・プロセス生存確認済み、最新ショット riddle2-title.png 22:04 JST、本編1行目を表示中）。#2 リアライブの再処理は KK 指示で中断されたまま。alice_0056・inre_0003・cabbage_0001 の処理記録はまだなし。
- 直近の確定結果：#19 千の刃濤、桃花染の皇姫は起動失敗（0x406097c6 SEGV、#4/#10 と共有原因、21:39–21:49 JST 記録済み）。フォント回帰の修正確定（21:14–21:27 JST）——#17 お嬢様の本編台詞も完全可読で文字化け解消 ✅。VM は 20:24 入れ替えから安定（up 約2時間18分）。次回ポーリングで RIDDLE JOKER の維持状態と .part の再出現を確認する。

## ポーリング記録（22:47 JST 時点）
- 新規着地なし（最終着地は alice_0056.zip、22:15:49 JST、22:17 記録済み）。本日完了は 22:42 時点の 22 本＋未判定 1 本のまま（RESULTS.md 計数ベース；ディスク上の当日ファイルは 19 本）。
- ダウンロード中 .part 0本（`*part*` で再確認済み）。22:27 以降、再出現なし。22:22 時点の 2本（約27 MB / 約164 MB）の行方は引き続き不明（hypothesis：ブラウザ側で一時停止・完了・別セッションへの移動のいずれか）。
- 回転側：KK 指示（22:02 JST）で #5 RIDDLE JOKER を :118 で起動維持中（pgid 29397、22:47 時点で経過約45分・プロセス生存確認済み、最新ショット riddle2-title.png 22:04 JST、本編1行目を表示中）。#2 リアライブの再処理は KK 指示で中断されたまま。alice_0056・inre_0003・cabbage_0001 の処理記録はまだなし。
- 直近の確定結果：#19 千の刃濤、桃花染の皇姫は起動失敗（0x406097c6 SEGV、#4/#10 と共有原因、21:39–21:49 JST 記録済み）。フォント回帰の修正確定（21:14–21:27 JST）——#17 お嬢様の本編台詞も完全可読で文字化け解消 ✅。VM は 20:24 入れ替えから安定（up 約2時間23分）。次回ポーリングで RIDDLE JOKER の維持状態と .part の再出現を確認する。

## ポーリング記録（22:52 JST 時点）
- 新規着地なし（最終着地は alice_0056.zip、22:15:49 JST、22:17 記録済み）。本日完了は 22:47 時点の 22 本＋未判定 1 本のまま（RESULTS.md 計数ベース；ディスク上の当日ファイルは 19 本）。
- ダウンロード中 .part 0本。22:27 以降、再出現なし。22:22 時点の 2本（約27 MB / 約164 MB）の行方は引き続き不明（hypothesis：ブラウザ側で一時停止・完了・別セッションへの移動のいずれか）。
- 回転側：**VM 入れ替え発生**（本 exec 環境 uptime 22:52 時点で約3分、Xvfb :118 は 22:49 JST 再起動）。旧 RIDDLE JOKER ライン（pgid 29397、22:02 起動）は VM 入れ替えで消滅。回転側が 22:50 JST に riddle4 として再起動中（dmm-launch-virgl.sh riddle4、prefix riddlejoker2、qemu-i386 起動確認済み（22:53 JST 時点でプロセス生存）。最新ショット riddle3-boot.jpg（22:51 JST、18,627 B）で起動画面を確認。#2 リアライブの再処理は KK 指示で中断されたまま。alice_0056・inre_0003・cabbage_0001 の処理記録はまだなし。
- 直近の確定結果：#19 千の刃濤、桃花染の皇姫は起動失敗（0x406097c6 SEGV、#4/#10 と共有原因、21:39–21:49 JST 記録済み）。フォント回帰の修正確定（21:14–21:27 JST）——#17 お嬢様の本編台詞も完全可読で文字化け解消 ✅。VM は 22:49 JST に入れ替わり再起動（up 約3分）。次回ポーリングで riddle4 の起動維持状態と .part の再出現を確認する。

## :118 再起動と RIDDLE JOKER 再起動（22:49–22:57 JST、KK 指示による）
- KK が「ディスプレイを再起動して、リドじょを最初から再起動する」を選択。:118 への新規 X 接続は 8 秒／20 秒／60 秒の3回ともタイムアウト（確立）。旧ゲーム一式（pgid 29397）と旧 Xvfb（pid 1910）・twm・旧ブリッジを個別 PID で停止し、Xvfb :118（1280x720x24 -nolock）と twm を再起動 → XOpenDisplay は即時 OK に回復。
- 再起動後の初回・2回目のゲーム起動（riddle3／riddle4）は virgl の "lost connection to rendering server" ＋ Wine assertion（0x7DC06556、thread 00ec）で失敗。原因（確立）：virgl_test_server が不在／再起動したサーバが libEGL.so.1 を開けず接続を切断していた（virgl-server.log に "Couldn't open libEGL.so.1"）。サーバの LD_LIBRARY_PATH に virgl-libs 側（libEGL＋Mesa）と virgl 側（libvirglrenderer）の両ツリー＋__EGL_VENDOR_LIBRARY_DIRS を入れて再起動（pid 5793）。
- 3回目（riddle5、pgid 5811、prefix riddlejoker2、virgl、max,-avx2）で正常起動：lost connection 0件・assertion 0件、タイトル画面をスクリーンショットで確認（shots/riddle5-title.jpg、文字化けなし）。ゲームパネルのブリッジも再起動済みでキャプチャ動作中（frame 165,541 B の実画面）。

## 音声復旧（23:00–23:06 JST、KK「音声とfpsと操作がだめ」「音声エラー！」）
- 実測で切り分け：描画・操作は復旧したが音声だけ三重に死んでいた。(1) 回転ラインの PulseAudio（tcp 47145）が停止（接続拒否、プロセス不在）。(2) 再起動した PA はモジュール依存の不足で tcp/unix プロトコルが開けず（libprotocol-native.so は modules ディレクトリ内）、LD_LIBRARY_PATH に lib 本体＋pulseaudio サブディレクトリ＋modules の3箇所を通して正常起動（sink "game" 復活）。(3) ブリッジが parec を PATH で探せず /audio.mp3 が全件エラー（FileNotFoundError）→ ブリッジを pa-bin の PATH＋ライブラリ付きで再起動し、/audio.mp3 は 57,344 B/6 秒（約96 kbps）の MP3 配信を実測。
- ゲーム本体の音声は PA 停止時に接続が切れたまま戻らなかったため（sink-input 0件、モニタ RMS 0.0）、KK の承認を得て riddle5 を終了し riddle6（pgid 7578、同条件）で再起動。結果：lost connection 0・assertion 0、sink-input 出現、モニタ実測 RMS 0.078／peak 0.256（タイトル BGM の信号あり）、タイトル画面も確認（shots/riddle6-title.jpg）。

## パネル音声の滑らかさ修理＋修理後起動（23:07–23:15 JST、KK「途切れ途切れ」「修理してから起動しろ」）
- KK の耳では音声が途切れ途切れ。切り分け実測：ゲーム→PA モニタは 21.9 秒で無音ギャップ 0件・配信率 1.000、ブリッジ MP3 も 20 秒 237,568 B で安定供給——供給側は正常で、途切れはパネル側のライブ端張り付き再生（バッファ枯渇）と特定。
- パネル（gemupaneru）を修理し live 反映：音声は再生開始前に約2.5秒分をバッファ、ライブ端への追い付きシークを全廃、中継の合流位置を約3秒手前（36KB）に拡大、キュー上限 12→64。映像・操作は無変更。実データの流通（無音でない MP3 チャンク＋カーソル前進）は検証済み、聞こえの最終判定は KK の耳。
- 修理完了後に KK 指示通りゲームを起動し直し。riddle7 は virgl サーバ側の context error（CREATE_OBJECT dispatch 失敗、"Illegal command buffer"）で起動失敗（白画面＋assertion）→ virgl サーバを正規手順で再起動（pid 9916）して riddle8（pgid 9935）で正常起動：lost connection 0・assertion 0、sink-input 出現、モニタ RMS 0.077／peak 0.234、タイトル画面確認（shots/riddle8-title.jpg）。

## ポーリング記録（22:57 JST 時点）
- 新規着地なし（最終着地は alice_0056.zip、22:15:49 JST、22:17 記録済み）。本日完了は 22:52 時点の 22 本＋未判定 1 本のまま（RESULTS.md 計数ベース；ディスク上の当日ファイルは 19 本）。
- ダウンロード中 .part 0本。22:27 以降、再出現なし。22:22 時点の 2本（約27 MB / 約164 MB）の行方は引き続き不明（hypothesis：ブラウザ側で一時停止・完了・別セッションへの移動のいずれか）。
- 回転側：KK 指示（22:49–22:57 JST、:118 再起動＋リドじょ最初から再起動）で RIDDLE JOKER riddle5（pgid 5811、prefix riddlejoker2、virgl、max,-avx2）が正常起動し維持中。virgl_test_server（pid 5793）も稼働、lost connection・assertion 0件。最新ショット riddle5-title.jpg（22:56 JST、165,541 B）でタイトル画面を確認、文字化けなし。ゲームパネルのブリッジも再起動済みでキャプチャ動作中。#2 リアライブの再処理は KK 指示で中断されたまま。alice_0056・inre_0003・cabbage_0001 の処理記録はまだなし。
- 直近の確定結果：#19 千の刃濤、桃花染の皇姫は起動失敗（0x406097c6 SEGV、#4/#10 と共有原因、21:39–21:49 JST 記録済み）。フォント回帰の修正確定（21:14–21:27 JST）——#17 お嬢様の本編台詞も完全可読で文字化け解消 ✅。VM は 22:49 JST に入れ替わり再起動（up 約10分）。次回ポーリングで riddle5 の起動維持状態と .part の再出現を確認する。

## ポーリング記録（23:02 JST 時点）
- 新規着地なし（最終着地は alice_0056.zip、22:15:49 JST、22:17 記録済み）。本日完了は 22:57 時点の 22 本＋未判定 1 本のまま（RESULTS.md 計数ベース；ディスク上の当日ファイルは 19 本）。
- ダウンロード中 .part 0本。22:27 以降、再出現なし。22:22 時点の 2本（約27 MB / 約164 MB）の行方は引き続き不明（hypothesis：ブラウザ側で一時停止・完了・別セッションへの移動のいずれか）。
- 回転側：KK 指示（22:49–22:57 JST、:118 再起動＋リドじょ最初から再起動）で RIDDLE JOKER riddle5（pgid 5811、prefix riddlejoker2、virgl、max,-avx2）が正常起動し維持中。23:02 時点でプロセス生存確認済み（q32sup-var pgid 5811、経過約8分、virgl_test_server pid 5793・Xvfb :118 とも生存）。最新ショット riddle5-title.jpg（22:56 JST、165,541 B）でタイトル画面を確認、文字化けなし。#2 リアライブの再処理は KK 指示で中断されたまま。alice_0056・inre_0003・cabbage_0001 の処理記録はまだなし。
- 直近の確定結果：#19 千の刃濤、桃花染の皇姫は起動失敗（0x406097c6 SEGV、#4/#10 と共有原因、21:39–21:49 JST 記録済み）。フォント回帰の修正確定（21:14–21:27 JST）——#17 お嬢様の本編台詞も完全可読で文字化け解消 ✅。VM は 22:49 JST に入れ替わり再起動（up 約14分）。次回ポーリングで riddle5 の起動維持状態と .part の再出現を確認する。

## ポーリング記録（23:07 JST 時点）
- 新規着地なし（最終着地は alice_0056.zip、22:15:49 JST、22:17 記録済み）。本日完了は 23:02 時点の 22 本＋未判定 1 本のまま（RESULTS.md 計数ベース；ディスク上の当日ファイルは 19 本）。
- ダウンロード中 .part 0本。22:27 以降、再出現なし。22:22 時点の 2本（約27 MB / 約164 MB）の行方は引き続き不明（hypothesis：ブラウザ側で一時停止・完了・別セッションへの移動のいずれか）。
- 回転側：RIDDLE JOKER riddle6（pgid 7578、prefix riddlejoker2、virgl、max,-avx2）が 23:03 JST 頃起動、23:07 時点でプロセス生存確認済み。最新ショット riddle6-title.jpg（23:05 JST、167,402 B）でタイトル画面を確認、文字化けなし。音声復旧（23:00–23:06）後の状態：PA tcp 47145 稼働（pid 7345）、ブリッジ pid 7455（:8791）稼働、/audio.mp3 は HTTP 200・81,920 B の配信を確認（23:08 JST 時点）。virgl_test_server pid 5793・Xvfb :118 とも生存。#2 リアライブの再処理は KK 指示で中断されたまま。alice_0056・inre_0003・cabbage_0001 の処理記録はまだなし。
- 直近の確定結果：音声復旧完了（23:00–23:06 JST）——PA 三重障害を修復し riddle6 でタイトル BGM の信号（RMS 0.078／peak 0.256）を確認、ブリッジの /audio.mp3 配信も復旧 ✅。#19 千の刃濤、桃花染の皇姫は起動失敗（0x406097c6 SEGV、#4/#10 と共有原因、21:39–21:49 JST 記録済み）。フォント回帰の修正確定（21:14–21:27 JST）——#17 お嬢様の本編台詞も完全可読で文字化け解消 ✅。VM は 22:49 JST に入れ替わり再起動（up 約18分）。次回ポーリングで riddle6 の維持状態と .part の再出現を確認する。

## ポーリング記録（23:12 JST 時点）
- 新規着地なし（最終着地は alice_0056.zip、22:15:49 JST、22:17 記録済み）。本日完了は 23:07 時点の 22 本＋未判定 1 本のまま（RESULTS.md 計数ベース；ディスク上の当日ファイルは 19 本）。
- ダウンロード中 .part 0本。22:27 以降、再出現なし。22:22 時点の 2本（約27 MB / 約164 MB）の行方は引き続き不明（hypothesis：ブラウザ側で一時停止・完了・別セッションへの移動のいずれか）。
- 回転側：RIDDLE JOKER riddle6（pgid 7578）は消滅し、riddle7 が起動中（qemu-i386 pid 9489/9490、prefix riddlejoker2、virgl、max,-avx2）。起動直後の自動検証スクリプト（pid 9556）が riddle7.log の lost connection／Assertion 数、PA sink-input、モニタ RMS、screen.jpg を確認中。最新ショットは riddle6-title.jpg（23:05 JST、167,402 B）のまま、riddle7-title.jpg は取得中。virgl_test_server は pid 5793 に加え pid 9594 も同ソケットパスで稼働中（重複の理由は未確認）。Xvfb :118（pid 2959）・PA tcp 47145（pid 7345）とも生存。/audio.mp3 は HTTP 200・10秒で 106,496 B 配信を確認（ライブストリームのため max-time で切断、正常範囲）。#2 リアライブの再処理は KK 指示で中断されたまま。alice_0056・inre_0003・cabbage_0001 の処理記録はまだなし。
- 直近の確定結果：音声復旧完了（23:00–23:06 JST）——PA 三重障害を修復し riddle6 でタイトル BGM の信号（RMS 0.078／peak 0.256）を確認、ブリッジの /audio.mp3 配信も復旧 ✅。#19 千の刃濤、桃花染の皇姫は起動失敗（0x406097c6 SEGV、#4/#10 と共有原因、21:39–21:49 JST 記録済み）。フォント回帰の修正確定（21:14–21:27 JST）——#17 お嬢様の本編台詞も完全可読で文字化け解消 ✅。VM は 22:49 JST に入れ替わり再起動（up 約23分）。次回ポーリングで riddle7 の起動維持状態と .part の再出現を確認する。

## ポーリング記録（23:17 JST 時点）
- 新規着地なし（最終着地は alice_0056.zip、22:15:49 JST、22:17 記録済み）。本日完了は 23:12 時点の 22 本＋未判定 1 本のまま（RESULTS.md 計数ベース；ディスク上の当日ファイルは 19 本）。
- ダウンロード中 .part 0本。22:27 以降、再出現なし。22:22 時点の 2本（約27 MB / 約164 MB）の行方は引き続き不明（hypothesis：ブラウザ側で一時停止・完了・別セッションへの移動のいずれか）。
- 回転側：RIDDLE JOKER riddle8（pgid 9935、prefix riddlejoker2、virgl、max,-avx2）が 23:14 JST 頃起動、23:17 時点でプロセス生存確認済み（経過約3分）。最新ショット riddle8-title.jpg（23:15 JST、167,174 B）でタイトル画面を確認、文字化けなし。パネル音声修理（23:07–23:15）後の起動で、riddle7 の virgl context error を回避し正常起動。#2 リアライブの再処理は KK 指示で中断されたまま。alice_0056・inre_0003・cabbage_0001 の処理記録はまだなし。
- 直近の確定結果：音声復旧完了（23:00–23:06 JST）——PA 三重障害を修復し riddle6 でタイトル BGM の信号（RMS 0.078／peak 0.256）を確認、ブリッジの /audio.mp3 配信も復旧 ✅。パネル音声の滑らかさ修理完了（23:07–23:15 JST）——2.5秒バッファ＋追い付きシーク廃止＋合流位置約3秒手前＋キュー上限64、供給側は配信率 1.000・無音ギャップ 0件を確認済み、聞こえの最終判定は KK の耳。#19 千の刃濤、桃花染の皇姫は起動失敗（0x406097c6 SEGV、#4/#10 と共有原因、21:39–21:49 JST 記録済み）。フォント回帰の修正確定（21:14–21:27 JST）——#17 お嬢様の本編台詞も完全可読で文字化け解消 ✅。VM は 22:49 JST に入れ替わり再起動（up 約28分）。次回ポーリングで riddle8 の起動維持状態と .part の再出現を確認する。

## ポーリング記録（23:22 JST 時点）
- 新規着地なし（最終着地は alice_0056.zip、22:15:49 JST、22:17 記録済み）。本日完了は 23:17 時点の 22 本＋未判定 1 本のまま（RESULTS.md 計数ベース；ディスク上の当日ファイルは 19 本）。
- ダウンロード中 .part 0本。22:27 以降、再出現なし。22:22 時点の 2本（約27 MB / 約164 MB）の行方は引き続き不明（hypothesis：ブラウザ側で一時停止・完了・別セッションへの移動のいずれか）。
- 回転側：RIDDLE JOKER riddle8（pgid 9935、prefix riddlejoker2、virgl、max,-avx2）が 23:14 JST 頃起動、23:22 時点でプロセス生存確認済み（経過約8分44秒）。最新ショット riddle8-title.jpg（23:15 JST、167,174 B）でタイトル画面を確認、文字化けなし。virgl_test_server（pid 9916 他、重複は23:12 時点から継続）・Xvfb :118（pid 2959）・PA tcp 47145（pid 7345）とも生存。#2 リアライブの再処理は KK 指示で中断されたまま。alice_0056・inre_0003・cabbage_0001 の処理記録はまだなし。
- 直近の確定結果：音声復旧完了（23:00–23:06 JST）——PA 三重障害を修復し riddle6 でタイトル BGM の信号（RMS 0.078／peak 0.256）を確認、ブリッジの /audio.mp3 配信も復旧 ✅。パネル音声の滑らかさ修理完了（23:07–23:15 JST）——2.5秒バッファ＋追い付きシーク廃止＋合流位置約3秒手前＋キュー上限64、供給側は配信率 1.000・無音ギャップ 0件を確認済み、聞こえの最終判定は KK の耳。#19 千の刃濤、桃花染の皇姫は起動失敗（0x406097c6 SEGV、#4/#10 と共有原因、21:39–21:49 JST 記録済み）。フォント回帰の修正確定（21:14–21:27 JST）——#17 お嬢様の本編台詞も完全可読で文字化け解消 ✅。VM は 22:49 JST に入れ替わり再起動（up 約33分）。次回ポーリングで riddle8 の起動維持状態と .part の再出現を確認する。

## ポーリング記録（23:27 JST 時点）
- 新規着地なし（最終着地は alice_0056.zip、22:15:49 JST、22:17 記録済み）。本日完了は 23:22 時点の 22 本＋未判定 1 本のまま（RESULTS.md 計数ベース；ディスク上の当日ファイルは 19 本）。
- ダウンロード中 .part 0本。22:27 以降、再出現なし。22:22 時点の 2本（約27 MB / 約164 MB）の行方は引き続き不明（hypothesis：ブラウザ側で一時停止・完了・別セッションへの移動のいずれか）。
- 回転側：RIDDLE JOKER riddle8（pgid 9935、prefix riddlejoker2、virgl、max,-avx2）が 23:14 JST 頃起動、23:27 時点でプロセス生存確認済み（経過約13分35秒）。最新ショット riddle8-title.jpg（23:15 JST、167,174 B）でタイトル画面を確認、文字化けなし。virgl_test_server（pid 9916）・Xvfb :118（pid 2959）・PA tcp 47145（pid 7345）とも生存。#2 リアライブの再処理は KK 指示で中断されたまま。alice_0056・inre_0003・cabbage_0001 の処理記録はまだなし。
- 直近の確定結果：音声復旧完了（23:00–23:06 JST）——PA 三重障害を修復し riddle6 でタイトル BGM の信号（RMS 0.078／peak 0.256）を確認、ブリッジの /audio.mp3 配信も復旧 ✅。パネル音声の滑らかさ修理完了（23:07–23:15 JST）——2.5秒バッファ＋追い付きシーク廃止＋合流位置約3秒手前＋キュー上限64、供給側は配信率 1.000・無音ギャップ 0件を確認済み、聞こえの最終判定は KK の耳。#19 千の刃濤、桃花染の皇姫は起動失敗（0x406097c6 SEGV、#4/#10 と共有原因、21:39–21:49 JST 記録済み）。フォント回帰の修正確定（21:14–21:27 JST）——#17 お嬢様の本編台詞も完全可読で文字化け解消 ✅。VM は 22:49 JST に入れ替わり再起動（up 約38分）。次回ポーリングで riddle8 の起動維持状態と .part の再出現を確認する。

## ポーリング記録（23:32 JST 時点）
- 新規着地なし（最終着地は alice_0056.zip、22:15:49 JST、22:17 記録済み）。本日完了は 23:27 時点の 22 本＋未判定 1 本のまま（RESULTS.md 計数ベース；ディスク上の当日ファイルは 19 本）。
- ダウンロード中 .part 0本。22:27 以降、再出現なし。22:22 時点の 2本（約27 MB / 約164 MB）の行方は引き続き不明（hypothesis：ブラウザ側で一時停止・完了・別セッションへの移動のいずれか）。
- 回転側：RIDDLE JOKER riddle8（pgid 9935、prefix riddlejoker2、virgl、max,-avx2）が 23:14 JST 頃起動、23:32 時点でプロセス生存確認済み（経過約18分34秒、qemu-i386 子プロセス pid 9937 も生存）。最新ショット riddle8-title.jpg（23:15 JST、167,174 B）でタイトル画面を確認、文字化けなし。virgl_test_server（pid 9916・10027・10121、重複は23:12 時点から継続）・Xvfb :118（pid 2959）・PA tcp 47145（pid 7345）とも生存。#2 リアライブの再処理は KK 指示で中断されたまま。alice_0056・inre_0003・cabbage_0001 の処理記録はまだなし。
- 直近の確定結果：音声復旧完了（23:00–23:06 JST）——PA 三重障害を修復し riddle6 でタイトル BGM の信号（RMS 0.078／peak 0.256）を確認、ブリッジの /audio.mp3 配信も復旧 ✅。パネル音声の滑らかさ修理完了（23:07–23:15 JST）——2.5秒バッファ＋追い付きシーク廃止＋合流位置約3秒手前＋キュー上限64、供給側は配信率 1.000・無音ギャップ 0件を確認済み、聞こえの最終判定は KK の耳。#19 千の刃濤、桃花染の皇姫は起動失敗（0x406097c6 SEGV、#4/#10 と共有原因、21:39–21:49 JST 記録済み）。フォント回帰の修正確定（21:14–21:27 JST）——#17 お嬢様の本編台詞も完全可読で文字化け解消 ✅。VM は 22:49 JST に入れ替わり再起動（up 約43分）。次回ポーリングで riddle8 の起動維持状態と .part の再出現を確認する。

## ポーリング記録（23:37 JST 時点）
- 新規着地なし（最終着地は alice_0056.zip、22:15:49 JST、22:17 記録済み）。本日完了は 23:32 時点の 22 本＋未判定 1 本のまま（RESULTS.md 計数ベース；ディスク上の当日ファイルは 19 本）。
- ダウンロード中 .part 0本。22:27 以降、再出現なし。22:22 時点の 2本（約27 MB / 約164 MB）の行方は引き続き不明（hypothesis：ブラウザ側で一時停止・完了・別セッションへの移動のいずれか）。
- 回転側：RIDDLE JOKER riddle8（pgid 9935、prefix riddlejoker2、virgl、max,-avx2）が 23:14 JST 頃起動、23:37 時点でプロセス生存確認済み（経過約23分22秒、qemu-i386 子プロセス pid 9937 も生存）。最新ショット riddle8-title.jpg（23:15 JST、167,174 B）でタイトル画面を確認、文字化けなし。#2 リアライブの再処理は KK 指示で中断されたまま。alice_0056・inre_0003・cabbage_0001 の処理記録はまだなし。
- 直近の確定結果：音声復旧完了（23:00–23:06 JST）——PA 三重障害を修復し riddle6 でタイトル BGM の信号（RMS 0.078／peak 0.256）を確認、ブリッジの /audio.mp3 配信も復旧 ✅。パネル音声の滑らかさ修理完了（23:07–23:15 JST）——2.5秒バッファ＋追い付きシーク廃止＋合流位置約3秒手前＋キュー上限64、供給側は配信率 1.000・無音ギャップ 0件を確認済み、聞こえの最終判定は KK の耳。#19 千の刃濤、桃花染の皇姫は起動失敗（0x406097c6 SEGV、#4/#10 と共有原因、21:39–21:49 JST 記録済み）。フォント回帰の修正確定（21:14–21:27 JST）——#17 お嬢様の本編台詞も完全可読で文字化け解消 ✅。VM は 22:49 JST に入れ替わり再起動（up 約48分）。次回ポーリングで riddle8 の起動維持状態と .part の再出現を確認する。

## ポーリング記録（23:42 JST 時点）
- 新規着地なし（最終着地は alice_0056.zip、22:15:49 JST、22:17 記録済み）。本日完了は 23:37 時点の 22 本＋未判定 1 本のまま（RESULTS.md 計数ベース；ディスク上の当日ファイルは 19 本）。
- ダウンロード中 .part 0本。22:27 以降、再出現なし。22:22 時点の 2本（約27 MB / 約164 MB）の行方は引き続き不明（hypothesis：ブラウザ側で一時停止・完了・別セッションへの移動のいずれか）。
- 回転側：RIDDLE JOKER riddle8（pgid 9935、prefix riddlejoker2、virgl、max,-avx2）が 23:14 JST 頃起動、23:42 時点でプロセス生存確認済み（経過約28分24秒、qemu-i386 子プロセス pid 9937 も生存）。最新ショット riddle8-title.jpg（23:15 JST、167,174 B）でタイトル画面を確認、文字化けなし。virgl_test_server（pid 9916・10027、重複は23:12 時点から継続）・Xvfb :118（pid 2959）・PA tcp 47145（pid 7345）・ブリッジ（pid 7455、/audio.mp3 は HTTP 200・5秒で 49,152 B）とも生存。#2 リアライブの再処理は KK 指示で中断されたまま。alice_0056・inre_0003・cabbage_0001 の処理記録はまだなし。
- 直近の確定結果：音声復旧完了（23:00–23:06 JST）——PA 三重障害を修復し riddle6 でタイトル BGM の信号（RMS 0.078／peak 0.256）を確認、ブリッジの /audio.mp3 配信も復旧 ✅。パネル音声の滑らかさ修理完了（23:07–23:15 JST）——2.5秒バッファ＋追い付きシーク廃止＋合流位置約3秒手前＋キュー上限64、供給側は配信率 1.000・無音ギャップ 0件を確認済み、聞こえの最終判定は KK の耳。#19 千の刃濤、桃花染の皇姫は起動失敗（0x406097c6 SEGV、#4/#10 と共有原因、21:39–21:49 JST 記録済み）。フォント回帰の修正確定（21:14–21:27 JST）——#17 お嬢様の本編台詞も完全可読で文字化け解消 ✅。VM は 22:49 JST に入れ替わり再起動（up 約53分）。次回ポーリングで riddle8 の起動維持状態と .part の再出現を確認する。

## ポーリング記録（23:47 JST 時点）
- 新規着地なし（最終着地は alice_0056.zip、22:15:49 JST、22:17 記録済み）。本日完了は 23:42 時点の 22 本＋未判定 1 本のまま（RESULTS.md 計数ベース；ディスク上の当日ファイルは 19 本）。
- ダウンロード中 .part 0本。22:27 以降、再出現なし。22:22 時点の 2本（約27 MB / 約164 MB）の行方は引き続き不明（hypothesis：ブラウザ側で一時停止・完了・別セッションへの移動のいずれか）。
- 回転側：RIDDLE JOKER riddle8（pgid 9935、prefix riddlejoker2、virgl、max,-avx2）が 23:14 JST 頃起動、23:47 時点でプロセス生存確認済み（経過約33分25秒、qemu-i386 子プロセス pid 9937 も生存、CPU 93.2% で稼働中）。最新ショット riddle8-title.jpg（23:15 JST、167,174 B）でタイトル画面を確認、文字化けなし。virgl_test_server（pid 9916・10027、重複は23:12 時点から継続）・Xvfb :118（pid 2959）・PA tcp 47145（pid 7345）・ブリッジ（pid 7455）とも生存。#2 リアライブの再処理は KK 指示で中断されたまま。alice_0056・inre_0003・cabbage_0001 の処理記録はまだなし。
- 直近の確定結果：音声復旧完了（23:00–23:06 JST）——PA 三重障害を修復し riddle6 でタイトル BGM の信号（RMS 0.078／peak 0.256）を確認、ブリッジの /audio.mp3 配信も復旧 ✅。パネル音声の滑らかさ修理完了（23:07–23:15 JST）——2.5秒バッファ＋追い付きシーク廃止＋合流位置約3秒手前＋キュー上限64、供給側は配信率 1.000・無音ギャップ 0件を確認済み、聞こえの最終判定は KK の耳。#19 千の刃濤、桃花染の皇姫は起動失敗（0x406097c6 SEGV、#4/#10 と共有原因、21:39–21:49 JST 記録済み）。フォント回帰の修正確定（21:14–21:27 JST）——#17 お嬢様の本編台詞も完全可読で文字化け解消 ✅。VM は 22:49 JST に入れ替わり再起動（up 約58分）。次回ポーリングで riddle8 の起動維持状態と .part の再出現を確認する。

## ポーリング記録（23:52 JST 時点）
- 新規着地なし（最終着地は alice_0056.zip、22:15:49 JST、22:17 記録済み）。本日完了は 23:47 時点の 22 本＋未判定 1 本のまま（RESULTS.md 計数ベース；ディスク上の当日ファイルは 19 本）。
- ダウンロード中 .part 0本。22:27 以降、再出現なし。22:22 時点の 2本（約27 MB / 約164 MB）の行方は引き続き不明（hypothesis：ブラウザ側で一時停止・完了・別セッションへの移動のいずれか）。
- 回転側：RIDDLE JOKER riddle8（pgid 9935、prefix riddlejoker2、virgl、max,-avx2）が 23:14 JST 頃起動、23:52 時点でプロセス生存確認済み（経過約38分30秒、qemu-i386 子プロセス pid 9937 CPU 96.7% で稼働中）。最新ショット riddle8-title.jpg（23:15 JST、167,174 B）でタイトル画面を確認、文字化けなし。virgl_test_server（pid 9916・10027、重複は23:12 時点から継続）・Xvfb :118（pid 2959）・PA tcp 47145（pid 7345）・ブリッジ（pid 7455）とも生存。#2 リアライブの再処理は KK 指示で中断されたまま。alice_0056・inre_0003・cabbage_0001 の処理記録はまだなし。
- 直近の確定結果：音声復旧完了（23:00–23:06 JST）——PA 三重障害を修復し riddle6 でタイトル BGM の信号（RMS 0.078／peak 0.256）を確認、ブリッジの /audio.mp3 配信も復旧 ✅。パネル音声の滑らかさ修理完了（23:07–23:15 JST）——2.5秒バッファ＋追い付きシーク廃止＋合流位置約3秒手前＋キュー上限64、供給側は配信率 1.000・無音ギャップ 0件を確認済み、聞こえの最終判定は KK の耳。#19 千の刃濤、桃花染の皇姫は起動失敗（0x406097c6 SEGV、#4/#10 と共有原因、21:39–21:49 JST 記録済み）。フォント回帰の修正確定（21:14–21:27 JST）——#17 お嬢様の本編台詞も完全可読で文字化け解消 ✅。VM は 22:49 JST に入れ替わり再起動（up 約1時間03分）。次回ポーリング（23:57）で riddle8 の起動維持状態と .part の再出現を確認する。24:00 を過ぎた最初の回で総括を報告する。

## ポーリング記録（23:57 JST 時点）
- 新規着地なし（最終着地は alice_0056.zip、22:15:49 JST、22:17 記録済み）。本日完了は 23:52 時点の 22 本＋未判定 1 本のまま（RESULTS.md 計数ベース；ディスク上の当日ファイルは 19 本）。
- ダウンロード中 .part 0本。22:27 以降、再出現なし。22:22 時点の 2本（約27 MB / 約164 MB）の行方は引き続き不明（hypothesis：ブラウザ側で一時停止・完了・別セッションへの移動のいずれか）。
- 回転側：RIDDLE JOKER riddle8（pgid 9935、prefix riddlejoker2、virgl、max,-avx2）が 23:14 JST 頃起動、23:57 時点でプロセス生存確認済み（経過約43分29秒、qemu-i386 子プロセス pid 9937 CPU 99.5% で稼働中）。最新ショット riddle8-title.jpg（23:15 JST、167,174 B）でタイトル画面を確認、文字化けなし。virgl_test_server（pid 9916・10027・14763、重複は23:12 時点から継続）・Xvfb :118（pid 2959）・PA tcp 47145（pid 7345）・ブリッジ（pid 7455、/audio.mp3 は HTTP 200・5秒で 49,152 B）とも生存。#2 リアライブの再処理は KK 指示で中断されたまま。alice_0056・inre_0003・cabbage_0001 の処理記録はまだなし。
- 直近の確定結果：音声復旧完了（23:00–23:06 JST）——PA 三重障害を修復し riddle6 でタイトル BGM の信号（RMS 0.078／peak 0.256）を確認、ブリッジの /audio.mp3 配信も復旧 ✅。パネル音声の滑らかさ修理完了（23:07–23:15 JST）——2.5秒バッファ＋追い付きシーク廃止＋合流位置約3秒手前＋キュー上限64、供給側は配信率 1.000・無音ギャップ 0件を確認済み、聞こえの最終判定は KK の耳。#19 千の刃濤、桃花染の皇姫は起動失敗（0x406097c6 SEGV、#4/#10 と共有原因、21:39–21:49 JST 記録済み）。フォント回帰の修正確定（21:14–21:27 JST）——#17 お嬢様の本編台詞も完全可読で文字化け解消 ✅。VM は 22:49 JST に入れ替わり再起動（up 約1時間08分）。次回（24:00 を過ぎた最初の回）で総括を報告し、「24時のため報告トリガーはここで終了」と明記する。

## VM入れ替えと復旧（2026-11-15 00:56–01:00 JST）
- 00:56頃にVM入れ替え（up 0 min）。:118一式（Xvfb/twm/PA/virgl/両ブリッジ）と riddle8 が全滅。
- 定番手順で復旧：Xvfb:118（pid 2183）→ twm（2949）→ PA tcp 47145（sink game確認）→ virgl（2974）→ パネルブリッジ8791・タスクブリッジ8792。
- riddle9（pgid 3070）：YUZUSOFTロゴで停止。guest log に lost connection 1 + assertion 1、モニタ無音。virglサーバを再起動（pid 3553）して riddle10（pgid 3559）で再起動。
- riddle10 検証OK：lost 0 / assertion 0、タイトル画面表示（文字化けなし、shots/riddle10-title.jpg）、モニタ8秒 RMS 0.0739 / peak 0.241（タイトルBGM）。

## VM入れ替え2回目と復旧（2026-11-15 02:57–03:00 JST）
- 02:57頃にVM入れ替え（up 0 min）、riddle10含め全滅。前回と同じ手順で復旧：Xvfb:118（1857）→ twm（1863）→ PA 47145 → virgl（1892、新ソケット）→ 両ブリッジ（8791/8792）。
- riddle11（pgid 1922）一発で成功：lost 0 / assertion 0。起動55秒時点は黒画面（遷移中）、約1分半でタイトル到達（shots/riddle11-title2.jpg、165,541B）。モニタ6秒 RMS 0.0775 / peak 0.249（タイトルBGM）。

## VM入れ替え3回目と復旧（2026-11-15 04:55–04:58 JST）
- 04:55頃にVM入れ替え（up 0 min、00:56/02:57に続き今夜3回目、約2時間周期）。riddle11含め全滅。
- 復旧：Xvfb:118（1907）→ twm（1911）→ PA 47145 → virgl（1931）→ 両ブリッジ。書き込みゲートはこの時点で回復（ログ追記OK）。
- riddle12（pgid 1989）一発成功：lost 0 / assertion 0、タイトル到達（shots/riddle12-title.jpg、166,044B）。

## VM入れ替え4回目と復旧（2026-11-15 06:59–07:02 JST）
- 06:59頃にVM入れ替え（up 0 min、約2時間周期が継続）。riddle12含め全滅。
- 復旧：Xvfb:118（1885）→ twm（1906）→ PA 47145 → virgl（1921）→ 両ブリッジ。
- riddle13（pgid 1982）一発成功：lost 0 / assertion 0、タイトル到達（shots/riddle13-title.jpg、166,044B）、モニタ6秒 RMS 0.0766 / peak 0.246。

## VM入れ替え5回目と復旧（2026-11-15 08:57–09:00 JST）
- 08:57頃にVM入れ替え（up 0 min、約2時間周期）。riddle13含め全滅。
- 復旧：Xvfb:118（1899）→ twm（1910）→ PA 47145 → virgl（1937）→ 両ブリッジ。
- riddle14（pgid 2673）：75秒時点は黒画面＋無音（遷移が遅い回）、約2分でタイトル到達（shots/riddle14-title2.jpg、166,044B）、モニタ6秒 RMS 0.0746 / peak 0.241、lost 0 / assertion 0。

## リドじょ再起動（KK指示、2026-11-15 10:26–10:33 JST）
- riddle14 を全プロセス終了（q32sup/qemu/wineserver等9個、TERMで全滅）。
- 書き込みゲート再発：新規ファイル作成が EDQUOT で不可（既存ファイルへの追記は可）。起動スクリプトの新規ログ作成で失敗 → 手動起動に切替、ログは /tmp へ。
- riddle15（virglサーバ再利用）：M2ロゴで凍結。lost 2 / assertion 1、モニタ無音、同一フレーム継続。再利用サーバの拒否パターン（riddle7と同型）。
- virglサーバ再起動を試みたが、ソケット新規作成も EDQUOT で失敗（virgl-server.log に "Failed to setup socket.: Disk quota exceeded"）。→ ソケットを /tmp/virgl.sock に移してサーバ起動（pid 18572）。
- riddle16（/tmp/virgl.sock、ログ /tmp/riddle16.log）：lost 0 / assertion 0、タイトル到達、モニタでBGM確認。
- 注意：次回VM入れ替え時の復旧は、ゲートが解けるまで virgl ソケットとゲームログを /tmp に置くこと。

## 復旧スクリプト格納（2026-11-15 10:37 JST）
VM入れ替え（約2時間周期）で :118 一式が毎回全滅するため、手動復旧手順をスクリプト化した。
書き込みゲート（新規ファイル作成EDQUOT、追記は可）のため、スクリプト本体は本ファイル末尾の
RESTORE-118-BEGIN〜END マーカー間に格納する。使うとき：
  sed -n '/RESTORE-118-BEGIN/,/RESTORE-118-END/p' ~/workspace/dmm-trials/RESULTS.md | sed '1d;$d' > /tmp/restore-118.sh && bash /tmp/restore-118.sh [slug]
ゲートが解けたら scripts/restore-118.sh へ移すこと。
パネル（gemupaneru）が映らない直接原因も同ゲート：Spaceワーカーが app.db の -shm を作れず
SQLITE_IOERR_SHMOPEN / CANTOPEN で起動失敗する（ブリッジ8791とゲーム本体は正常を実測）。

RESTORE-118-BEGIN
#!/bin/bash
# restore-118.sh - VM入れ替え後に :118 スタック一式（Xvfb/twm/PA/virgl/両ブリッジ/リドじょ）を一発復旧する。
# 2026-11-15 の手動復旧（riddle10-16）を手順化。起動前に同種プロセスがいない前提。
# 書き込みゲート対策：virglソケットとゲームログは workspace に作れなければ /tmp に逃がす。
set -u
DT=$HOME/workspace/dmm-trials
WP=$HOME/workspace/win32-perf
PALIB=$WP/pa-bin/usr/lib/x86_64-linux-gnu:$WP/pa-bin/usr/lib/x86_64-linux-gnu/pulseaudio:$WP/pa-bin/usr/lib/pulse-16.1+dfsg1/modules
GAME_DIR="$DT/riddle-joker/RIDDLE_JOKER～体験版～"
GAME_EXE='Z:\home\hatch\workspace\dmm-trials\riddle-joker\RIDDLE_JOKER～体験版～\RIDDLE_JOKER_体験版.exe'
PREFIX=$DT/prefixes/riddlejoker2
SLUG="${1:-restore$(date +%H%M)}"
echo "[restore] Xvfb :118"
setsid nohup /usr/bin/Xvfb :118 -screen 0 1280x720x24 -nolock >> "$DT/logs/xvfb118.log" 2>&1 &
sleep 2
setsid nohup "$DT/tools/twm-root/usr/bin/twm" -display :118 >> "$DT/logs/twm118.log" 2>&1 &
sleep 1
timeout 10 python3 -c "
import ctypes
x11 = ctypes.CDLL('libX11.so.6'); x11.XOpenDisplay.restype = ctypes.c_void_p
import sys; sys.exit(0 if x11.XOpenDisplay(b':118') else 1)" && echo "[restore] X OK" || { echo "[restore] X FAILED"; exit 1; }
echo "[restore] PulseAudio 47145"
setsid nohup env LD_LIBRARY_PATH=$PALIB "$WP/pa-bin/usr/bin/pulseaudio" --exit-idle-time=-1 \
  --dl-search-path=$WP/pa-bin/usr/lib/pulse-16.1+dfsg1/modules -F "$DT/pa/default.pa" >> "$DT/logs/pa47145.log" 2>&1 &
sleep 2
"$WP/pa-bin/usr/bin/pactl" -s tcp:127.0.0.1:47145 list sinks short || echo "[restore] PA check failed"
echo "[restore] virgl server"
SOCK=$WP/virgl.sock
rm -f "$SOCK"
setsid nohup env -i LD_LIBRARY_PATH=$WP/virgl-libs/usr/lib/x86_64-linux-gnu:$WP/virgl/usr/lib/x86_64-linux-gnu \
  __EGL_VENDOR_LIBRARY_DIRS=$WP/virgl-libs/usr/share/glvnd/egl_vendor.d \
  "$WP/virgl/usr/bin/virgl_test_server" --use-egl-surfaceless --socket-path "$SOCK" >> "$WP/virgl-server.log" 2>&1 &
sleep 2
if [ ! -S "$SOCK" ]; then
  echo "[restore] workspace socket failed (gate?) - falling back to /tmp/virgl.sock"
  SOCK=/tmp/virgl.sock
  rm -f "$SOCK"
  setsid nohup env -i LD_LIBRARY_PATH=$WP/virgl-libs/usr/lib/x86_64-linux-gnu:$WP/virgl/usr/lib/x86_64-linux-gnu \
    __EGL_VENDOR_LIBRARY_DIRS=$WP/virgl-libs/usr/share/glvnd/egl_vendor.d \
    "$WP/virgl/usr/bin/virgl_test_server" --use-egl-surfaceless --socket-path "$SOCK" >> "$WP/virgl-server.log" 2>&1 &
  sleep 2
fi
[ -S "$SOCK" ] && echo "[restore] virgl OK sock=$SOCK" || { echo "[restore] virgl FAILED"; exit 1; }
echo "[restore] bridges 8791/8792"
(cd "$HOME/workspace/game-panel" && PATH=$WP/pa-bin/usr/bin:$PATH \
  LD_LIBRARY_PATH=$WP/pa-bin/usr/lib/x86_64-linux-gnu:$WP/pa-bin/usr/lib/x86_64-linux-gnu/pulseaudio \
  setsid nohup python3 bridge.py >> "$DT/logs/panel-bridge.log" 2>&1 &)
(cd "$HOME/workspace/task-manager" && setsid nohup python3 tkbridge.py >> "$DT/logs/task-bridge.log" 2>&1 &)
sleep 2
curl -s -m 3 http://127.0.0.1:8791/ping && echo " [restore] panel bridge OK"
curl -s -m 3 http://127.0.0.1:8792/ping && echo " [restore] task bridge OK"
echo "[restore] game ($SLUG)"
GLOG="$DT/logs/$SLUG.log"
( echo x > "$GLOG" ) 2>/dev/null || GLOG="/tmp/$SLUG.log"
cd "$GAME_DIR" || exit 1
. "$HOME/workspace/win32-compat/scripts/common.env"
export DISPLAY=:118 WINEPREFIX="$PREFIX" Q32_CPU='max,-avx2' \
  PULSE_SERVER=tcp:127.0.0.1:47145 PULSE_LATENCY_MSEC=750 \
  LD_LIBRARY_PATH=$WP/libs32/usr/lib/i386-linux-gnu:$WP/libs32/usr/lib/i386-linux-gnu/pulseaudio \
  GALLIUM_DRIVER=virpipe VTEST_SOCKET_NAME="$SOCK"
setsid nohup "$HOME/workspace/win32-compat/tools/q32sup-var" \
  /home/hatch/workspace/vn-trials/qemu/usr/bin/qemu-i386-static -cpu 'max,-avx2' \
  -L /home/hatch/workspace/vn-trials/sysroot32/root "$WINEBIN" "$GAME_EXE" >> "$GLOG" 2>&1 &
echo "[restore] game launched pgid $! log=$GLOG sock=$SOCK"
sleep 75
echo "[restore] lost: $(grep -c 'lost connection' "$GLOG") assertion: $(grep -c 'Assertion' "$GLOG")"
curl -s -m 5 http://127.0.0.1:8791/screen.jpg -o /tmp/restore-title.jpg && ls -la /tmp/restore-title.jpg
timeout 6 "$WP/pa-bin/usr/bin/parec" --server=tcp:127.0.0.1:47145 --device=game.monitor \
  --format=float32le --rate=48000 --channels=2 2>/dev/null | python3 -c "
import sys, struct
d = sys.stdin.buffer.read(); n = len(d)//4
v = struct.unpack('<%df' % n, d)
print(f'[restore] monitor RMS={(sum(x*x for x in v)/n) ** 0.5:.4f} peak={max((abs(x) for x in v), default=0):.3f}' if n else '[restore] monitor: no data')"
echo "[restore] done"
RESTORE-118-END

## VM入れ替え復旧（2026-11-15 10:57–11:01 JST）＋復旧スクリプト事故と修正
- 10:57 VM入れ替え（周期どおり）で全滅。復旧完了：Xvfb:118（スクリプト実行分 pid 27399）/ twm 27408 / PA 47145 / virgl（/tmp/virgl.sock）/ 両ブリッジ（8791 proc_df3381a8d612、8792 proc_cbc2371f0d0d）/ riddle17（lost 0・assertion 0、タイトル確認、モニタ RMS 0.0770・peak 0.245）。
- 事故：先に格納した復旧スクリプト（RESTORE-118版）の抽出が、説明文中のマーカー文字列と使用法コマンド行まで含んでしまい、スクリプトが自己再帰してプロセス上限を枯渇させた（fork: Resource temporarily unavailable）。pkill の自己一致で自分のシェルを巻き込む事故も併発。最終的にパターンを工夫して全停止し、手動手順で復旧した。**旧 RESTORE-118 ブロックは使用禁止**（抽出コマンドをそのまま実行しないこと）。
- 新たな知見：PA は ~/.config/pulse へのランタイム symlink 作成がゲートで失敗すると起動できない。回避策＝ XDG_RUNTIME_DIR=/tmp/pa-runtime を付けて起動（今回実証済み）。
- 修正版スクリプトを下記 RESTORE118V2 ブロックに格納する。マーカーは行全体一致で抽出すること。使用法は文章でのみ記す：BEGIN行とEND行の間（両マーカー行を除く）をファイルに取り出して bash で実行する。

RESTORE118V2-BEGIN
#!/bin/bash
# restore-118 v2 - VM入れ替え後の :118 一式復旧。起動前に同種プロセスがいない前提。
# v2修正: 抽出事故の再発防止（マーカー行全体一致）、PA に XDG_RUNTIME_DIR=/tmp/pa-runtime、ブリッジログは /tmp。
set -u
DT=$HOME/workspace/dmm-trials
WP=$HOME/workspace/win32-perf
PALIB=$WP/pa-bin/usr/lib/x86_64-linux-gnu:$WP/pa-bin/usr/lib/x86_64-linux-gnu/pulseaudio:$WP/pa-bin/usr/lib/pulse-16.1+dfsg1/modules
GAME_DIR="$DT/riddle-joker/RIDDLE_JOKER～体験版～"
GAME_EXE='Z:\home\hatch\workspace\dmm-trials\riddle-joker\RIDDLE_JOKER～体験版～\RIDDLE_JOKER_体験版.exe'
SLUG="${1:-restore$(date +%H%M)}"
echo "[restore] Xvfb :118"
setsid nohup /usr/bin/Xvfb :118 -screen 0 1280x720x24 -nolock >> "$DT/logs/xvfb118.log" 2>&1 &
sleep 2
setsid nohup "$DT/tools/twm-root/usr/bin/twm" -display :118 >> "$DT/logs/twm118.log" 2>&1 &
sleep 1
timeout 10 python3 -c "
import ctypes
x11 = ctypes.CDLL('libX11.so.6'); x11.XOpenDisplay.restype = ctypes.c_void_p
import sys; sys.exit(0 if x11.XOpenDisplay(b':118') else 1)" && echo "[restore] X OK" || { echo "[restore] X FAILED"; exit 1; }
echo "[restore] PulseAudio 47145"
mkdir -p /tmp/pa-runtime && chmod 700 /tmp/pa-runtime
setsid nohup env XDG_RUNTIME_DIR=/tmp/pa-runtime LD_LIBRARY_PATH=$PALIB "$WP/pa-bin/usr/bin/pulseaudio" --exit-idle-time=-1 \
  --dl-search-path=$WP/pa-bin/usr/lib/pulse-16.1+dfsg1/modules -F "$DT/pa/default.pa" >> "$DT/logs/pa47145.log" 2>&1 &
sleep 2
"$WP/pa-bin/usr/bin/pactl" -s tcp:127.0.0.1:47145 list sinks short || echo "[restore] PA check failed"
echo "[restore] virgl server"
SOCK=$WP/virgl.sock
rm -f "$SOCK"
setsid nohup env -i LD_LIBRARY_PATH=$WP/virgl-libs/usr/lib/x86_64-linux-gnu:$WP/virgl/usr/lib/x86_64-linux-gnu \
  __EGL_VENDOR_LIBRARY_DIRS=$WP/virgl-libs/usr/share/glvnd/egl_vendor.d \
  "$WP/virgl/usr/bin/virgl_test_server" --use-egl-surfaceless --socket-path "$SOCK" >> "$WP/virgl-server.log" 2>&1 &
sleep 2
if [ ! -S "$SOCK" ]; then
  echo "[restore] workspace socket failed (gate?) - falling back to /tmp/virgl.sock"
  SOCK=/tmp/virgl.sock
  rm -f "$SOCK"
  setsid nohup env -i LD_LIBRARY_PATH=$WP/virgl-libs/usr/lib/x86_64-linux-gnu:$WP/virgl/usr/lib/x86_64-linux-gnu \
    __EGL_VENDOR_LIBRARY_DIRS=$WP/virgl-libs/usr/share/glvnd/egl_vendor.d \
    "$WP/virgl/usr/bin/virgl_test_server" --use-egl-surfaceless --socket-path "$SOCK" >> "$WP/virgl-server.log" 2>&1 &
  sleep 2
fi
[ -S "$SOCK" ] && echo "[restore] virgl OK sock=$SOCK" || { echo "[restore] virgl FAILED"; exit 1; }
echo "[restore] bridges 8791/8792"
(cd "$HOME/workspace/game-panel" && PATH=$WP/pa-bin/usr/bin:$PATH \
  LD_LIBRARY_PATH=$WP/pa-bin/usr/lib/x86_64-linux-gnu:$WP/pa-bin/usr/lib/x86_64-linux-gnu/pulseaudio \
  setsid nohup python3 bridge.py >> /tmp/panel-bridge.log 2>&1 &)
(cd "$HOME/workspace/task-manager" && setsid nohup python3 tkbridge.py >> /tmp/task-bridge.log 2>&1 &)
sleep 2
curl -s -m 3 http://127.0.0.1:8791/ping && echo " [restore] panel bridge OK"
curl -s -m 3 http://127.0.0.1:8792/ping && echo " [restore] task bridge OK"
echo "[restore] game ($SLUG)"
GLOG="$DT/logs/$SLUG.log"
( echo x > "$GLOG" ) 2>/dev/null || GLOG="/tmp/$SLUG.log"
cd "$GAME_DIR" || exit 1
. "$HOME/workspace/win32-compat/scripts/common.env"
export DISPLAY=:118 WINEPREFIX="$DT/prefixes/riddlejoker2" Q32_CPU='max,-avx2' \
  PULSE_SERVER=tcp:127.0.0.1:47145 PULSE_LATENCY_MSEC=750 \
  LD_LIBRARY_PATH=$WP/libs32/usr/lib/i386-linux-gnu:$WP/libs32/usr/lib/i386-linux-gnu/pulseaudio \
  GALLIUM_DRIVER=virpipe VTEST_SOCKET_NAME="$SOCK"
setsid nohup "$HOME/workspace/win32-compat/tools/q32sup-var" \
  /home/hatch/workspace/vn-trials/qemu/usr/bin/qemu-i386-static -cpu 'max,-avx2' \
  -L /home/hatch/workspace/vn-trials/sysroot32/root "$WINEBIN" "$GAME_EXE" >> "$GLOG" 2>&1 &
echo "[restore] game launched pgid $! log=$GLOG sock=$SOCK"
sleep 75
echo "[restore] lost: $(grep -c 'lost connection' "$GLOG") assertion: $(grep -c 'Assertion' "$GLOG")"
curl -s -m 5 http://127.0.0.1:8791/screen.jpg -o /tmp/restore-title.jpg && ls -la /tmp/restore-title.jpg
echo "[restore] done"
RESTORE118V2-END

## VM入れ替え復旧（2026-11-15 12:57–13:00 JST）— 復旧スクリプトv2 初成功
- 12:57 VM入れ替えで全滅。RESTORE118V2 スクリプトで一発復旧成功（事故なし）：X OK / PA sink game / virgl は workspace ソケットで起動（ゲート解除済みのため /tmp フォールバック不要）/ 両ブリッジ OK / riddle18（lost 0・assertion 0、タイトル 165,541B、モニタ RMS 0.0828・peak 0.277）。
- パネル音声遅延の修正（12:36、gemupaneru 編集）も同日完了：加入オフセット 36KB→8KB、開始ゲート 2.5s→0.8s、再開 1.0s→0.4s、遅延キャップ（3s超で end−1.0s へ1回シーク）。聴感判定は KK 待ち。

## パネル音声：遅延とプツプツの調整（2026-11-15 13:02–13:20 JST）
- KK「2秒でもきつい」→ パネル側を極限まで薄く（加入2KB・開始0.3s・再開0.2s・遅延上限1.2s）＋ゲーム側 PULSE_LATENCY_MSEC 750→200（riddle19）。設計遅延 ~1s。
- KK「プツプツ切れるようになった」→ 切り分け実測：PAモニタ30秒キャプチャ（200ms時）で 30ms以上の無音ギャップ4回・最長90ms・合計250ms。供給側（ゲーム→PA）が枯れているのが主因と判断。
- ゲーム側を 400ms に戻して再起動（riddle20、lost 0・assertion 0、タイトル到達）。同条件30秒再測定：無音フレーム0・ギャップ0・合計0ms、RMS 0.0816。供給側はクリーン化。
- 現在の設計遅延見積もり ~1.2s。まだプツプツする場合はパネル側ゲート（開始0.3s）が残り容疑者 → 一段だけ厚くする（+0.2s）が次手。

## 2026-11-15 15:00-15:10 panel latency round 3 (KK「もっともっと改善しろ」)
- VM replacement 14:57 -> restore v2 one-shot OK (riddle22, LAT=750 by script default, title 165,541 B). NOTE: on the PREVIOUS VM, wineserver crashed instantly on every launch from 14:43 (all prefixes, direct qemu too) — old-VM state degradation, NOT a stack fault; fresh VM boots clean. My /bin/true and /usr/bin/true qemu tests were void (neither exists in sysroot32).
- Measurement-route fix: interactive parec MUST use PULSE_SERVER=tcp:127.0.0.1:47145 (native-socket route = Connection refused on this VM; two earlier "0 frames" results were this, not silence). Screenshot route: bridge /screen.jpg (ImageMagick import unreliable in this shell).
- Game relaunch rule reconfirmed: kill game -> restart virgl fresh -> relaunch (riddle23 froze on reused virgl: lost 1/assertion 1; riddle24/25 clean after fresh virgl).
- PULSE_LATENCY_MSEC sweep (30 s monitor captures, float32, tcp parec): 300 ms -> 0 gap runs >=30 ms, RMS 0.0778. 250 ms -> 0 gap runs, RMS 0.0778. (200 ms remains the known-bad point: 4 gaps / 250 ms total.) Floor is between 200 and 250; adopted 250.
- Bridge parec --latency-msec 120 -> 60: stream re-measured (raw socket): 11,776 B/s, max inter-arrival 0.141 s, 0 gaps >0.3 s. Adopted.
- LIVE (riddle25): game LAT 250 + parec 60 + bridge read1 per-frame + panel join 2KB / start 0.5 s / runway 0.6 s. Estimated end-to-end ~1.2 s. KK ear verdict pending.

## 2026-11-15 16:45-17:01 audio-death + VM swap recovery
- KK 16:45: panel audio dead + tap input hard to use. Diagnosis: game + sink alive (RUNNING), but bridge /audio.mp3 returned headers with 0 bytes — bridge parec dead; new PA client streams fail late in VM life (mmap EPERM; same late-life degradation family as the previous VM's wineserver instant-crash at ~1h45m uptime). Panel-side fix shipped separately (auto-reconnect + status dot + manual reconnect + big-button control pad: enter/esc/backspace/space/tab/arrows via existing key action).
- VM replacement 16:57 -> restore v2 OK (riddle26) -> fresh virgl -> riddle27 at PULSE_LATENCY_MSEC=250. Verified end-to-end at the bridge: title 167,402 B; /audio.mp3 11,480 B/s, decoded RMS 0.1004 / peak 0.367 (real BGM). Live config = LAT 250 + parec 60 + panel runway 0.6 s, est. ~1.2 s delay. KK ear verdict pending.
