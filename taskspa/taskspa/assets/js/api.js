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

  edit_job(data, id) {
    $.ajax("/api/v1/jobs/" + id, {
      method: "put",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: JSON.stringify({ job: data }),
      success: (resp) => {
      },
    });
  }

  delete_job(id) {
    $.ajax("/api/v1/jobs/" + id, {
      method: "delete",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      success: (resp) => {
      },
    });
  }

  submit_worker(data) {
    $.ajax("/api/v1/workers", {
      method: "post",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: JSON.stringify({ worker: data }),
      success: (resp) => {
        store.dispatch({
          type: 'ADD_WORKER',
          worker: resp.data,
        });
      },
    });
  }

  submit_login(data) {
    $.ajax("/api/v1/token", {
      method: "post",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: JSON.stringify(data),
      success: (resp) => {
        store.dispatch({
          type: 'SET_TOKEN',
          token: resp,
        });
      },
    });
  }
}

export default new TheServer();

