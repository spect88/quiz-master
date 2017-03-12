class ProgressBar extends React.Component {
  render () {
    const percentage = 100 * this.props.step / this.props.outOf;
    const progressBarStyle = {
      width: `${percentage}%`
    }

    return (
      <div className="progress">
        <div
          className="progress-bar"
          role="progressbar"
          aria-valuenow={this.props.step}
          aria-valuemin="1"
          aria-valuemax={this.props.outOf}
          style={progressBarStyle}>
          {this.props.step}/{this.props.outOf}
        </div>
      </div>
    );
  }
}

ProgressBar.propTypes = {
  step: React.PropTypes.number,
  outOf: React.PropTypes.number
};
