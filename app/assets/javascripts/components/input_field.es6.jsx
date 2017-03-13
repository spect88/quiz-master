class InputField extends React.Component {
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
        <input
          id={this.props.id}
          className="form-control"
          type="text"
          autoComplete="off"
          value={value}
          onChange={this.onChange}/>
        <ErrorMessage error={error}/>
      </div>
    );
  }

  renderError(error) {
    if (!error) return '';
    return <p className="text-danger">{error}</p>;
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

InputField.propTypes = {
  model: React.PropTypes.object,
  attribute: React.PropTypes.string,
  id: React.PropTypes.string,
  label: React.PropTypes.string,
  onChange: React.PropTypes.func
};
