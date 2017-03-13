class BusyIndicator extends React.Component {
  render() {
    if (!this.props.loading) return null;

    return <div className="busy-indicator"></div>;
  }
}

BusyIndicator.propTypes = {
  loading: React.PropTypes.bool
};
