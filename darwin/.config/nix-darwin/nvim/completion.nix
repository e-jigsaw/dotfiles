{
  # 補完エンジン: blink.cmp (高速)
  plugins.blink-cmp = {
    enable = true;
    settings = {
      # super-tab: Tab で選択中の候補を確定 (default は C-y 確定 / Tab はスニペット用)
      keymap.preset = "super-tab";
      sources.default = [ "lsp" "path" "snippets" "buffer" ];
      completion.documentation.auto_show = true;
    };
  };
}
