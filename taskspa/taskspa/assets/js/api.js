import store from './store';

class TheServer {
  request_jobs() {
    $.ajax("/api/v1/jobs", {
      method: "get",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      success: (resp) => {
        store.dispatch({
          type: 'JOBS_LIST',
          jobs: resp.data,
        });
      },
    });
  }

  request_workers() {
    $.ajax("/api/v1/workers", {
      method: "get",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      success: (resp) => {
        store.dispatch({
          type: 'WORKERS_LIST',
          workers: resp.data,
        });
      },
    });
  }

  submit_job(data) {
    $.ajax("/api/v1/jobs", {
      method: "post",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: JSON.stringify({ job: data }),
      success: (resp) => {
        store.dispatch({
          type: 'ADD_JOB',
          job: resp.data,
        });
      },
    });
  }
}

export default new TheServer();

