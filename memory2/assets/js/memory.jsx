import React from 'react';
import ReactDOM from 'react-dom';
import { Button } from 'reactstrap';

export default function game_init(root, channel) {
  ReactDOM.render(<MemoryGame channel={channel} />, root);
}

// App state for Hangman is:
// {
//    word: String    // the word to be guessed
//    guesses: String // letters guessed so far
// }
//
// A TodoItem is:
//   { name: String, done: Bool }


class MemoryGame extends React.Component {
  constructor(props) {
    super(props);
    this.channel = props.channel;
    this.state = { skel: "", goods: [], bads: [], max: 10, 
                   cards: [],
                   clicks: 0,
                   score: 0,
			previousCardPos: -1,
                totalMatches:  0,
		lockScreen: false  };

    this.channel.join()
        .receive("ok", this.gotView.bind(this))
        .receive("error", resp => { console.log("Unable to join", resp) });
  }

  gotView(view) {
    console.log("New view", view);
    this.setState(view.game);
  }

  sendGuess(ev) {
    this.channel.push("guess", { letter: ev.key })
        .receive("ok", this.gotView.bind(this));
  }

  flip(pos) {
    this.channel.push("flip", { pos: pos })
        .receive("ok", this.gotView.bind(this));
  }


  toggle(side) {
    var side = +!this.state.side;
    this.setState({side: side});
  }
  
  reset() {
	for(var i=0; i <16; i++){
		this.state.cards[i].face = false;
		this.state.cards[i].match = false;
	}
	this.state.totalMatches = 0;
	this.state.clicks = 0;
	this.state.score = 0;
	this.state.lockScreen = false;
	this.state.previousCardPos = -1;
	this.state.cards = _.shuffle(this.state.cards);
	document.getElementById("score").innerText = 0;
    	this.setState({cards: this.state.cards,
			clicks: this.state.clicks,
			score: this.state.score,
			lockScreen: this.state.lockScreen,
			previousCardPos: this.previousCardPos,
			totalMatches: this.state.totalMatches});
  }
  changeScore(value){
	this.state.score = this.state.score + value;
	this.setState({score: this.state.score});
	document.getElementById("score").innerText = this.state.score;
  }
 
  coverFace(pos){
//	this.state.cards[pos].face = false;
//	this.state.cards[this.state.previousCardPos].face = false;
//	this.state.previousCardPos = -1;	
    	setTimeout(() =>  {this.state.cards[pos].face = false;
        this.state.cards[this.state.previousCardPos].face = false;
	for(var i=0; i <16; i++){
		if(this.state.cards[i].match == false){
			this.state.cards[i].face = false;
		}
	}
        this.state.previousCardPos = -1;
	this.setState({cards: this.state.cards,
			previousCardPos: this.previousCardPos})}, 1000);
  } 
  checkForMatch(pos){
    if(this.state.previousCardPos != -1) {
      if(this.state.cards[this.state.previousCardPos].value === this.state.cards[pos].value){
         this.state.cards[pos].face = true;
         this.state.totalMatches++;
	 this.state.cards[this.state.previousCardPos].match = true;
         this.state.cards[pos].match = true;
    	 this.changeScore(10);
      } else {
		this.state.cards[pos].face = true;
		this.coverFace(pos);

	}
    }
    this.setState({cards: this.state.cards,
		   score: this.state.score,
		   totalMatches: this.state.totalMatches});
  }
  
  checkActive(){
    var count =0;
    for(var i=0; i < 16; i ++) {
	if(this.state.cards[i].face == true && this.state.cards[i].match == false){
		count++;
        }
    }
    if(count == 2){
	return true;
    }
  }

  flip2(pos) {
    if(this.state.cards[pos].match) {
        return;
    }
    if(this.state.previousCardPos == pos) {
	return;
    }
    if(this.state.lockScreen) {
	return;
    }
    if(this.checkActive()){
	return;
    }
    this.state.clicks = this.state.clicks+1;
    this.changeScore(-2);
    if(this.state.clicks % 2 === 0) {
        this.checkForMatch(pos);
    } else {
        this.state.cards[pos].face = true;
    }    

    this.state.previousCardPos = pos;
    this.setState({clicks: this.state.clicks,
		   cards: this.state.cards,
		   score: this.state.score,
                   previousCardPos: this.state.previousCardPos});
   //   console.log(this.state);
  }

  render() {
    var toggle = this.toggle.bind(this);
    return (
      <div className="container">
 		<div className="row">
			<div className="col-md">
				<Card root={this} pos={0} />	
			</div>
			<div className="col-md">
				<Card root={this} pos={1} />	
			</div>
			<div className="col-md">
				<Card root={this} pos={2} />	
			</div>
			<div className="col-md">
				<Card root={this} pos={3} />	
			</div>
		</div>
 		<div className="row">
			<div className="col-md">
				<Card root={this} pos={4} />	
			</div>
			<div className="col-md">
				<Card root={this} pos={5} />	
			</div>
			<div className="col-md">
				<Card root={this} pos={6} />	
			</div>
			<div className="col-md">
				<Card root={this} pos={7} />	
			</div>
		</div>
 		<div className="row">
			<div className="col-md">
				<Card root={this} pos={8} />	
			</div>
			<div className="col-md">
				<Card root={this} pos={9} />	
			</div>
			<div className="col-md">
				<Card root={this} pos={10} />	
			</div>
			<div className="col-md">
				<Card root={this} pos={11} />	
			</div>
		</div>
 		<div className="row">
			<div className="col-md">
				<Card root={this} pos={12} />	
			</div>
			<div className="col-md">
				<Card root={this} pos={13} />	
			</div>
			<div className="col-md">
				<Card root={this} pos={14} />	
			</div>
			<div className="col-md">
				<Card root={this} pos={15} />	
			</div>
		</div>
		<button type="button" onClick={() => this.reset()}>Reset</button>
		<h1>Score</h1>
		<h1 id="score">{this.state.score}</h1>
      <div className="row">


        <div className="col-6">
          <Word state={this.state} />
        </div>
        <div className="col-6">
          <Lives state={this.state} />
        </div>
        <div className="col-6">
          <Guesses state={this.state} />
        </div>
        <div className="col-6">
          <GuessInput guess={this.sendGuess.bind(this)} />
        </div>
      </div>
   </div>
    );
  }
}

function Card(params){
  if(params.root.state.cards.length != 0) {
	if(params.root.state.cards[params.pos].face == true && params.root.state.cards[params.pos].match == false){
		let ele = params.root.state.cards[params.pos].value;
		return	<div className="card" onClick={() => params.root.flip(params.pos)}>
			{ele}</div>
	} else if(params.root.state.cards[params.pos].match == true){
                let ele = params.root.state.cards[params.pos].value;
                return  <div className="donecard">
                        {ele}</div>
	} else{
		return	<div className="closecard" onClick={() => params.root.flip(params.pos)}>
		Click Me </div>;
	}
  } else {
		return <div> Loading </div>
  }
}

function Word(params) {
  let state = params.state;

  let letters = _.map(state.skel, (xx, ii) => {
    return <span style={{padding: "1ex"}} key={ii}>{xx}</span>;
  });

  return (
    <div>
      <p><b>The Word</b></p>
      <p>{letters}</p>
    </div>
  );
}

function Lives(params) {
  let state = params.state;

  return <div>
    <p><b>Guesses Left:</b></p>
    <p>{state.max - state.bads.length}</p>
  </div>;
}

function Guesses(params) {
  let state = params.state;

  return <div>
    <p><b>Bad Guesses</b></p>
    <p>{state.bads.join(" ")}</p>
  </div>;
}

function GuessInput(params) {
  return <div>
    <p><b>Type Your Guesses</b></p>
    <p><input type="text" onKeyPress={params.guess} /></p>
  </div>;
}
