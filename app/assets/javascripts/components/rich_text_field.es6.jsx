class RichTextField extends React.Component {
  constructor(props) {
    super(props);
    this.onChange = this.onChange.bind(this);
  }

  render() {
    const value = this.props.model[this.props.attribute];
    const error = this.props.model[this.props.attribute + 'Error'];

    return (
      <div className={'form-group' + (error ? ' has-error' : '')}>
        <label htmlFor={this.props.id}>{this.props.label}</label>
        <RichTextEditor
          value={value}
          onChange={this.onChange}
          className="rich-text-editor" />
        <ErrorMessage error={error}/>
      </div>
    );
  }

  onChange(value) {
    const modifiedModel = {
      // preserve other attributes of model
      ...this.props.model,
      // modify changed value
      [this.props.attribute]: value,
      // clear validation errors
      [this.props.attribute + 'Error']: null
    };

    this.props.onChange(modifiedModel);
  }
}

RichTextField.propTypes = {
  model: React.PropTypes.object,
  attribute: React.PropTypes.string,
  id: React.PropTypes.string,
  label: React.PropTypes.string,
  onChange: React.PropTypes.func
};
