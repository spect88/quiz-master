class RichTextField extends React.Component {
  constructor(props) {
    super(props);
    this.onChange = this.onChange.bind(this);
  }

  render() {
    const value = this.props.model[this.props.attribute] || '';
    const error = this.props.model[this.props.attribute + 'Error'];

    return (
      <div className={'form-group' + (error ? ' has-error' : '')}>
        <label htmlFor={this.props.id}>{this.props.label}</label>
        <textarea
          id={this.props.id}
          className="form-control"
          value={value}
          onChange={this.onChange}/>
        <ErrorMessage error={error}/>
      </div>
    );
  }

  onChange(event) {
    const modifiedModel = {
      // preserve other attributes of model
      ...this.props.model,
      // modify changed value
      [this.props.attribute]: event.target.value,
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
