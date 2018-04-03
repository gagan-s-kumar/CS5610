import { createStore, combineReducers } from 'redux';
import deepFreeze from 'deep-freeze';

/*
 *  state layout:
 *  {
 *   posts: [... Posts ...],
 *   users: [... Users ...],
 *   form: {
 *     user_id: null,
 *     body: "",
 *   }
 * }
 *
 * */

function jobs(state = [], action) {
  switch (action.type) {
  case 'JOBS_LIST':
    return [...action.jobs];
  case 'ADD_JOB':
    return [action.job, ...state];
  default:
    return state;
  }
}

function workers(state = [], action) {
  switch (action.type) {
  case 'WORKERS_LIST':
    return [...action.workers];
  default:
    return state;
  }
}

let empty_form = {
  worker_id: "",
  title: "",
  description: "",
  duration: "",
};

function form(state = empty_form, action) {
  switch (action.type) {
  case 'UPDATE_FORM':
    return Object.assign({}, state, action.data);
  case 'CLEAR_FORM':
    return empty_form;
  default:
    return state;
  }
}

function root_reducer(state0, action) {
  console.log("reducer", action);
  // {posts, users, form} is ES6 shorthand for
  // {posts: posts, users: users, form: form}
  let reducer = combineReducers({jobs, workers, form});
  let state1 = reducer(state0, action);
  console.log("state1", state1);
  return deepFreeze(state1);
};

let store = createStore(root_reducer);
export default store;


