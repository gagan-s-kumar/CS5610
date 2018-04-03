import React from 'react';
import Job from './job';

export default function Feed(params) {
  let jobs = _.map(params.jobs, (pp) => <Job key={pp.id} job={pp} />);
  return <div>
    { jobs }
  </div>;
}
