// Serialize and deserialize react-rte's EditorValue objects
//
window.richTextSerializer = {
  deserialize: function deserialize(string) {
    if (!string) return rte.createEmptyValue();

    return rte.createValueFromString(string, 'markdown');
  },

  serialize: function serialize(richText) {
    return richText.toString('markdown');
  },

  isRichTextBlank: function isRichTextBlank(richText) {
    var cleanText =
      richTextSerializer
        .serialize(richText)
        .trim()
        .replace(/\u200b/, '');

    return cleanText == '';
  }
};
