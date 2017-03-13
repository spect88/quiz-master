class ErrorMessage extends React.Component {
  render() {
    if (this.props.error == null) return null;

    return <p className="text-danger">{this.props.error}</p>;
  }
}

ErrorMessage.propTypes = {
  error: React.PropTypes.string
};
