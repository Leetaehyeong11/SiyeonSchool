<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="views/common/common.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="resources/css/login.css">
<style>
#background{
	position: relative;
	display: flex;
	width: 100%;
	height: 100%;
}

.canvas {
	top: 0;
	left: 0;
	pointer-events: none;
	width: 100%;
	height: 100%;
	position: absolute;
	z-index: -1;
}

#login{
	border: 1px solid #77ddff;
	background-color: rgb(223, 247, 255);
	border-radius: 20px;
	width: 1000px;
	height: 600px;
	margin: auto;
	display: flex;
	z-index: 10;
}

#left{
	border-right-color: #77ddff;
	border-right-style: solid;
	border-right-width: 1px;
}

#left, #right {
	width: 50%;
	height: 100%;
	}

#left img{
	width: 250px;
	margin: auto;
	margin-top: 50px;
}
#right img{
	width: 45%;
	margin: auto;
	margin-top: 50px;
	margin-bottom: 20px;
}
#left p{
	text-align: center;
	font-weight: bold;
	margin: 20px 50px;
}
#right p{
	font-size: 24px;
	font-weight: 800;
	margin: 0 0 0 50px;
}

#right table{
	margin: auto;
	margin-bottom: 20px;
	background-color: #C2F0FF;
}

.first{
	background-color: #A98AFF;
	width: 106px;
	height: 1px;
	opacity: 0.5;
}
.second{
	height: 35px;
	vertical-align:middle;
	font-weight: 600;
}
.first:hover{
	opacity: 1;
}

input{
	width: 410px;
	height: 40px;
	border-radius: 5px;
}
form input{
	margin: 10px 0 20px 45px
}

input::placeholder{font-size: 11px; color:#a98affc9;}

#null{background-color: rgb(223, 247, 255);
width: 15px;}

form{position: relative;}

button{
	width: 152px;
	height: 47px;
	border-radius: 5px;
	background-color: #46D3FF;
	color: white;
	font-size: 20px;
	font-weight: 700;
	border: none;
	position: absolute;
	top: 230px;
	left: 175px;
}

button:hover{
	background-color: #00c3ff;
	cursor: pointer;
}

ul{display: flex;}

li{
	position: relative;
	top: 100px;
	left: 120px;
	font-weight: 600;
}

li::before{
	position: absolute;
	content: "";
	display: block;
	width: 2px;
	height: 18px;
	background-color: black;
}
li a{padding: 12px;}

li:first-child::before{display: none;}

</style>
</head>
<body>
	<!-- 이 "홈으로" a태그는 로그인 페이지 구현 끝날때까지 남겨주세요! -->
	
	<!-- <p>
		위 "홈으로" 태그만 남겨주시고, 다 지우셔도 됩니다!<br> 화면구현하시는데 방해가 안되도록 absolute
		포지션으로 잡아놓았습니다. <br> <br> 나중에 로그인 화면이 구현이 다 되면, 홈으로 이동할 수 있게
		부탁드려요.<br> 그땐 당연히 저 위에 "홈으로" 태그도 지우셔도 됩니다. <br> 감사합니다!! - 동규
	</p>
	-->
	<div id="background">
		<a id="homeBtn" href="<%=contextPath%>/home">홈으로</a>
		<canvas id="canvas" class="canvas"></canvas>
		<div id="login">
			<div id="left">
				<img src="resources/images/login_logo.png" alt=""> <br>
				<p>
					아무튼간에 잘해보자잉~아무튼간에 잘해보자잉~잉~아무튼간에 잘해보자잉~아무튼간에 잘해보자잉~아무튼간에 잘해보자잉~아무튼간에 잘해보자잉~아무튼간에 잘해보자잉~아무튼간에 잘해보자잉~ <br>
				</p>
			</div>
			<div id="right">
				<img src="resources/images/SiS_Logo.png" alt="">
				<table border="1">
					<tr>
						<td class="first"></td>
						<td rowspan="2" id="null">&nbsp;</td>
						<td class="first"></td>
					</tr>
					<tr>
						<th class="second">학 생</th>
						<th class="second">관 리 자</th>
					</tr>
				</table>
				<form action="">
					<p>아이디</p>
					<input type="text" name="userId" placeholder=" 영문, 숫자 조합으로 입력해주세요.(6~18자) "><br>
					<p>비밀번호</p>
					<input type="password" name="userPwd" placeholder=" 영문, 숫자, 특수문자(!,@,#,$,%,^,&,* 만 사용) 조합으로 입력해주세요.(6~18자)"><br>
					<button type="submit">로 그 인</button>
				</form>
				<ul>
					<li><a href="http://localhost:8222/SiS/UserIdPwdFind">아이디 / 비밀번호 찾기 </a></li>
					<li><a href="http://localhost:8222/SiS/singIn">회원가입</a></li>
				</ul>
			</div>
		</div>
	</div>
	<script>
	    let mouse, originx, originy, cvs;
		
		 // Safari doesn't support EventTarget
		 var EventTarget = EventTarget || false;
		
		 // addEventListener shorthand
		 if (EventTarget) {
		   EventTarget.prototype.evt = function (event, callback) {
		     return this.addEventListener(event, callback);
		   }
		 } else {
		   window.evt = function (event, callback) {
		     return this.addEventListener(event, callback);
		   };
		   document.evt = function (event, callback) {
		     return this.addEventListener(event, callback);
		   };
		   Element.prototype.evt = function (event, callback) {
		     return this.addEventListener(event, callback);
		   };
		 }
		
		 // getElementById shorthand
		 function $(elemId) {
		     return document.getElementById(elemId);
		 }
		
		 function init() {
		     cvs = $("canvas");
		
		     resizeCanvas(cvs);
		
		     window.evt('resize', () => resizeCanvas(cvs), false);
		     window.evt("mousemove", function (e) {
		         mouse = getMousePos(cvs, e);
		         originx = mouse.x;
		         originy = mouse.y;
		       
		     });
		     
		     var network = new Field(0, 0, 50);
		     var emit = new Emitter(0, 0, 50);
		     
		     animateCanvas(cvs, function () {
		         network.animate();
		         emit.animate();
		     });
		 }
		
		 // Individual particle
		 class Point {
		     constructor(x, y, canvas, dia) {
		         this.canvas = canvas || cvs;
		         this.x = x || 0;
		         this.y = y || 0;
		         this.vx = 0;
		         this.vy = 0;
		         this.speed = Math.random() * .5 + .2;
		         this.angle = Math.random() * 360;
		         this.diaSet = dia || 2 + Math.random() * 10;
		         this.dia = this.diaSet;
		         this.age = 0;
		         let hue = Math.floor(Math.random()*360);
		         this.fill = 'hsl('+hue+', 95%, 70%)';
		         this.line = Math.random() > .5 ? true : false;
		     }
		
		     emit(life) {
		         let s = this.speed * 2;
		         this.angle += Math.random() * 10 - 5;
		         this.x += s * Math.cos(this.angle * Math.PI / 180);
		         this.y += s * Math.sin(this.angle * Math.PI / 180);
		         this.age += 1 / life;
		         this.boundary();
		     }
		
		     boundary() {
		         if (this.x < 0) {
		             this.x = this.canvas.width;
		         }
		         if (this.x > this.canvas.width) {
		             this.x = 0;
		         }
		         if (this.y < 0) {
		             this.y = this.canvas.height;
		         }
		         if (this.y > this.canvas.height) {
		             this.y = 0;
		         }
		     }
		
		     field(life) {
		         let s = this.speed;
		         this.angle += Math.random() * 10 - 5;
		         this.x += s * Math.cos(this.angle * Math.PI / 180);
		         this.y += s * Math.sin(this.angle * Math.PI / 180);
		         this.age += 1 / life;
		         this.boundary();
		     }
		
		     shrink(life) {
		         this.dia = (1 - this.age) * this.diaSet;
		     }
		
		     draw() {
		         let ctx = this.canvas.getContext('2d'),
		             x = this.x,
		             y = this.y,
		             dia = this.dia,
		             age = this.age;
		
		         ctx.beginPath();
		         ctx.fillStyle = this.fill;
		         ctx.strokeStyle = this.fill;
		         ctx.lineWidth = 2;
		         ctx.arc(x, y, dia, 0, 2 * Math.PI);
		         ctx.closePath();
		         
		         this.line !== true ? ctx.fill() : ctx.stroke();
		     }
		 }
		
		 class ParticleGroup {
		
		     setPosition(x, y) {
		         this.x = x;
		         this.y = y;
		     }
		
		     getPosition(x, y) {
		         return {
		             x: this.x,
		             y: this.y
		         };
		     }
		
		     spawn(x, y, amount, dia) {
		
		         var arr = [];
		         dia = dia || false;
		
		         amount = amount || 1;
		
		         if (amount > 1) {
		             for (let i = 0; i < amount; i++) {
		                 if (dia) {
		                     arr.push(new Point(x, y, cvs, dia));
		                 }
		                 else {
		                     arr.push(new Point(x, y, cvs));
		                 }
		                 
		             }
		         } else {
		             arr = new Point(x, y, cvs, dia);
		         }
		
		         return arr;
		     }
		 }
		
		 // Particle Emitter
		 class Emitter extends ParticleGroup {
		     constructor(x, y, life, mouse, dia) {
		         super();
		
		         if (mouse === undefined) {
		             this.mouse = true;
		         } else {
		            //  this.mouse = mouse;
		         }
		
		         this.particles = [];
		         this.x = x || 0;
		         this.y = y || 0;
		         this.life = life || 20;
		         this.canvas = cvs;
		         this.dia = dia || false;
		     }
		
		     animate() {
		         let particles = this.particles;
		         if (this.mouse) {
		             this.setPosition(originx, originy);
		         }
		
		         let mul = 1;
		
		         for (let i = 0; i < mul; i++) {
		             particles.push(this.spawn(this.x, this.y, 1));
		         }
		         
		         if (particles.length > this.life * mul) {
		             for (let i = 0; i < mul; i++) {
		                 particles.shift();
		             }
		         }
		
		         this.render(this.canvas);
		     }
		     
		     render() {
		         let life = this.life;
		         let ctx = this.canvas.getContext('2d');
		         let particles = this.particles;
		
		         for (let i = 0; i < particles.length; i++) {
		             const p = particles[i];
		             p.draw();
		             p.emit(this.life);
		             p.shrink();
		         }
		     }
		 }
		
		 // Particle Field
		 class Field extends ParticleGroup {
		     constructor(x, y, life) {
		         super();
		         this.particles = [];
		         this.canvas = cvs;
		         this.x = x || 0;
		         this.y = y || 0;
		         this.life = life;
		
		         for (let i = 0; i < this.life; i++) {
		             let x = Math.random() * cvs.width,
		                 y = Math.random() * cvs.height;
		
		             this.particles.push(this.spawn(x, y, 1));
		         }
		     }
		
		     animate() {
		         this.render(canvas);
		     }
		
		     render(canvas) {
		         let ctx = this.canvas.getContext('2d');
		         let particles = this.particles;
		
		         for (let i = 0; i < particles.length; i++) {
		             const p = particles[i];
		             p.draw();
		             p.field(this.life);
		         }
		     }
		 }
		
		 // get the mouse position relative to the canvas
		 function getMousePos(cvs, evt) {
		     const rect = cvs.getBoundingClientRect();
		     return {
		         x: evt.clientX - rect.left,
		         y: evt.clientY - rect.top
		     };
		 }
		
		 // animate the canvas
		 function animateCanvas(canvas, callback) {
		
		     const ctx = canvas.getContext('2d');
		     ctx.clearRect(0, 0, canvas.width, canvas.height);
		     callback();
		
		     requestAnimationFrame(animateCanvas.bind(null, canvas, callback));
		 }
		
		 // Update canvas size to fill window
		 function resizeCanvas(canvas) {
		     canvas.width = window.innerWidth;
		     canvas.height = window.innerHeight;
		     originx = canvas.width / 2;
		     originy = canvas.height / 2;
		 }


		
		 init();
		 

    </script>

</body>
</html>



















