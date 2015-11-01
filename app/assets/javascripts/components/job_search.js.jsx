var IntlMixin     = ReactIntl.IntlMixin;
var FormattedDate = ReactIntl.FormattedDate;

var JobSearch = React.createClass({
  render: function() {
    return (
    <div>
    { JSON.parse(this.props.jobs).map(function(data, i){
     return <SearchResult id={data.job.id} title={data.job.title} labels={data.labels} expire_at={data.job.expire_at}/>
    }) }
    </div>
    )
  }
});
var SearchResult = React.createClass({
  render: function() {
    var spanStyle = {
      margin: '3px'
    };
    return (
      <div className="well well-sm">
       <h4>
        <a href={'/job/'+this.props.id}> {this.props.title}</a>
         <span className="label label-danger pull-right">締切:
            <FormattedDate value={this.props.expire_at} day="numeric" month="long" year="numeric"/>
         </span>
         </h4>
      { this.props.labels.map(function(label, i){
        return (
            <span className="label label-success" style={spanStyle} >
            <i className="fa fa-tag"></i>
            {label.name}
            </span>
         ) })}
      </div>
    ) 
  }
})
