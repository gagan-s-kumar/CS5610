import React from 'react';
import ReactDOM from 'react-dom';
import { Provider, connect } from 'react-redux';
import { BrowserRouter as Router, Route } from 'react-router-dom';

import Nav from './nav';
import Feed from './feed';
import Workers from './workers';
import JobForm from './job-form';

export default function taskspa_init(store) {
  ReactDOM.render(
    <Provider store={store}>
      <Taskspa state={store.getState()} />
    </Provider>,
    document.getElementById('root'),
  );
}

let Taskspa = connect((state) => state)((props) => {
  console.log("propshere", props);
  return (
    <Router>
      <div>
        <Nav />
        <Route path="/" exact={true} render={() =>
          <div>
            <JobForm />
            <Feed jobs={props.jobs} />
          </div>
        } />
        <Route path="/workers" exact={true} render={() =>
          <Workers workers={props.workers} />
        } />
        <Route path="/workers/:worker_id" render={({match}) =>
          <Feed jobs={_.filter(props.jobs, (pp) =>
            match.params.worker_id == pp.worker.id )
          } />
        } />
      </div>
    </Router>
  );
});

