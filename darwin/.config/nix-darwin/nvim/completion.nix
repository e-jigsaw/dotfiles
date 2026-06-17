{
  # 補完エンジン: blink.cmp (高速)
  plugins.blink-cmp = {
    enable = true;
    settings = {
      keymap.preset = "default";
      sources.default = [ "lsp" "path" "snippets" "buffer" ];
      completion.documentation.auto_show = true;
    };
  };
}
