import React from 'react';
import ReactDOM from 'react-dom';
import { Button } from 'reactstrap';

export default function run_demo(root) {
  ReactDOM.render(<Demo side={0}/>, root);
}

class Demo extends React.Component {
  constructor(props) {
    super(props);
    this.state = { clicks: 0,
		   score: 0,
		   cards: [{value:'A', face:false, match:false, pos:0},
			   {value:'B', face:false, match:false, pos:1},
			   {value:'C', face:false, match:false, pos:2},
			   {value:'D', face:false, match:false, pos:3},
			   {value:'E', face:false, match:false, pos:4},
			   {value:'F', face:false, match:false, pos:5},
			   {value:'G', face:false, match:false, pos:6},
			   {value:'H', face:false, match:false, pos:7},
			   {value:'H', face:false, match:false, pos:8},
			   {value:'G', face:false, match:false, pos:9},
			   {value:'F', face:false, match:false, pos:10},
			   {value:'E', face:false, match:false, pos:11},
			   {value:'D', face:false, match:false, pos:12},
			   {value:'C', face:false, match:false, pos:13},
			   {value:'B', face:false, match:false, pos:14},
			   {value:'A', face:false, match:false, pos:15}
			],
		previousCardPos: -1,
                totalMatches:  0,
		lockScreen: false 	
		};
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

  flip(pos) {
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
		<h1 id="score">0</h1>
	</div>
    );
  }
}
function Card(params){
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
}
