var ScheduleForm = React.createClass({
  handleSubmit: function(e) {
    e.preventDefault();
    var name = React.findDOMNode(this.refs.name).value.trim();
    var address = React.findDOMNode(this.refs.address).value.trim();
    var limit = React.findDOMNode(this.refs.limit).value.trim();
    var datetime_from = React.findDOMNode(this.refs.datetime_from).value.trim();
    var datetime_to = React.findDOMNode(this.refs.datetime_to).value.trim();
    var params = {
        'course_id': this.props.course_id,
        'name': name,
        'address': address,
        'limit': limit,
        'datetime_from': datetime_from,
        'datetime_to': datetime_to
        
    }
    // TODO: send request to the server
    $.ajax({
      type: "POST",
      url: '/api/schedules',
      data: params,
      success: this.handleSubmitSuccess,
      error: this.handleSubmitFailure,
      dataType: 'json'
    });  
    return;
  },
  handleSubmitSuccess: function(data){
    console.log('success')
    this.setState({schedules: data});
    React.findDOMNode(this.refs.name).value = '';
    React.findDOMNode(this.refs.address).value = '';
    React.findDOMNode(this.refs.limit).value = '';
    React.findDOMNode(this.refs.datetime_from).value = '';
    React.findDOMNode(this.refs.datetime_to).value = '';

},
componentDidMount: function() {
        $('.datetimepicker').datetimepicker();
    },
 handleSubmitFailure: function(){
    console.log('failed')
    React.findDOMNode(this.refs.name).value = '';
    React.findDOMNode(this.refs.address).value = '';
    React.findDOMNode(this.refs.limit).value = '';
    React.findDOMNode(this.refs.datetime_from).value = '';
    React.findDOMNode(this.refs.datetime_to).value = '';

},
  getInitialState: function() {
    return {
      schedules: JSON.parse(this.props.schedules)
    } 
  },
  render: function() {
    console.log(this.state.schedules.length)
    return(
    <div>
    { this.state.schedules.map(function(object, i){
        return <ScheduleData schedule={object} index={i}/>;
    }) }
    <form className='form-horizontal' onSubmit={this.handleSubmit}>
      <legend>第{this.state.schedules.length+1}次</legend>
        <div className="form-group">
          <label className="col-lg-2 control-label">课程名称</label>
          <div className="col-lg-10">
            <input ref="name" placeholder="例:XX课程第一期" className="form-control" required type="text"/>
          </div>
        </div>
        <div className="form-group">
          <label className="col-lg-2 control-label">地点</label>
          <div className="col-lg-10">
            <input ref="address" className="form-control" required type="text"/>
          </div>
        </div>
        <div className="form-group">
          <label className="col-lg-2 control-label">上限人数</label>
          <div className="col-lg-10">
            <input ref="limit" className="form-control" required type="text"/>
          </div>
        </div>
      <div className="form-group form-inline">
        <label for="CourseStarttime" className="col-lg-2 control-label">课程时间</label>
        <div className="col-lg-10">
          <input ref="datetime_from" className="form-control datetimepicker" required readonly="readonly" type="text"/>
          〜
          <input ref="datetime_to" className="form-control datetimepicker" required readonly="readonly" type="text"/>
        </div>
      </div>
      <div className="form-group">
        <div className="col-lg-10 col-lg-offset-2">
        <button type="submit" className="btn btn-primary">添加课程</button>
        </div>
      </div>
    </form>
    </div>
      );
  }
});
var ScheduleData = React.createClass({
   render: function() {
    var divstyle={
        width: "100%",
      };
    return(
      <div className="container" style={divstyle} >
      <legend>第{this.props.index+1}次</legend>
       <table className="table table-bordered">
          <tr>
            <th>课时名称</th>
            <td>{this.props.schedule.name}</td>
            <th>授课地点</th>
            <td>{this.props.schedule.address}</td>
          </tr>
          <tr>
            <th>人数限制</th>
            <td>{this.props.schedule.limit}</td>
            <th>授课时间</th>
            <td>{this.props.schedule.datetime_from} ~ {this.props.schedule.datetime_to}</td>
          </tr>
      </table>
      </div>
  );
  }
});

