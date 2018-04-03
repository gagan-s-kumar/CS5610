import React from 'react';
import ReactDOM from 'react-dom';
import { BrowserRouter as Router, Route } from 'react-router-dom';

import Nav from './nav';
import Feed from './feed';
import Workers from './workers';
import JobForm from './job-form';

export default function taskspa_init() {
  let root = document.getElementById('root');
  ReactDOM.render(<Taskspa />, root);
}

class Taskspa extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      jobs: [],
      workers: [],
    };

    this.request_jobs();
    this.request_workers();
  }

  request_jobs() {
    $.ajax("/api/v1/jobs", {
      method: "get",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      success: (resp) => {
        this.setState(_.extend(this.state, { jobs: resp.data }));
      },
    });
  }

  request_workers() {
    $.ajax("/api/v1/workers", {
      method: "get",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      success: (resp) => {
        this.setState(_.extend(this.state, { workers: resp.data }));
      },
    });
  }
  
  render() {
    return (
      <Router>
        <div>
          <Nav />
          <Route path="/" exact={true} render={() => 
            <div>
              <JobForm workers={this.state.workers} />
              <Feed jobs={this.state.jobs} />
            </div>
          } />
          <Route path="/workers" exact={true} render={() =>
            <Workers workers={this.state.workers} />
          } />
          <Route path="/workers/:worker_id" render={({match}) =>
            <Feed jobs={_.filter(this.state.jobs, (pp) =>
              match.params.worker_id == pp.worker.id )
            } />
          } />
        </div>
      </Router>
    );
  }
}
