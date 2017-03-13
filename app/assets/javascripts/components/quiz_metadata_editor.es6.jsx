class QuizMetadataEditor extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <div>
        <InputField
          label="Title"
          model={this.props.metadata}
          attribute="title"
          id="quiz_title"
          onChange={this.props.onChange}/>
        <RichTextField
          label="Description"
          model={this.props.metadata}
          attribute="description"
          id="quiz_description"
          onChange={this.props.onChange}/>
      </div>
    );
  }
}

QuizMetadataEditor.propTypes = {
  metadata: React.PropTypes.object,
  onChange: React.PropTypes.func
};
