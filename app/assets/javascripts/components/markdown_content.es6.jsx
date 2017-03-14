class MarkdownContent extends React.Component {
  render() {
    const innerHTML = {
      __html: marked(this.props.content, { sanitize: true })
    };

    // the markdown content is sanitized, so there's no risk of XSS
    return <div dangerouslySetInnerHTML={innerHTML}/>
  }
}

MarkdownContent.propTypes = {
  content: React.PropTypes.string
};
