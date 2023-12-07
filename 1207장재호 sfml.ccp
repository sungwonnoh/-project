#include <SFML/Graphics.hpp>
#include <iostream>
#include <string>
#include <vector>
#include <time.h>
#include <cmath>
#include <windows.h>
#include <iomanip>
#include "Item.h"
#include <cstdlib>
#include <ctime>

using namespace std;
using namespace sf;

class MyRect {

public:

	RectangleShape rect;

	MyRect(double posX, double posY, double width, double height, double angle, const Color& mycolor) {

		rect.setPosition(posX, posY); //사각형의 왼쪽 좌상단의 좌표를 지정
		rect.setSize(Vector2f(width, height)); //width, height (가로, 세로)
		rect.setRotation(angle);//왼쪽 좌상단이 각의 꼭짓점이 되고, 시계방향으로 회전
		rect.setFillColor(mycolor);
	}
};



int main()
{
	int nX = 1000; //게임 창 크기 조정
	int nY = 800;
	RenderWindow window(VideoMode(nX, nY), "Fortress");


	window.setFramerateLimit(100);

	//대포 가로세로
	double width = 30;
	double height = 90;

	MyRect myrect{ width, (double)nY, width, height, 225.0 , Color::Blue }; //대포 생성(나타날 x좌표, y좌표, 가로, 세로, 각도, 색)

	float defaultPower = 2;
	float power = defaultPower;
	float maxPower = 12;
	float currentangle = 270 - myrect.rect.getRotation(); //생각하기 쉽도록 각도 조정
	float vx = power * cos(currentangle * 3.14 / 180); //x방향 속도
	float vy = -power * sin(currentangle * 3.14 / 180);//y방향 속도

	//색깔변수 선언
	int col = 0;
	Item item[12]; //아이템 구체 8개 배열

	for (int i = 0; i < 12; i++) {
		col = rand() % 4; //랜덤으로 0~3수 생성
		if (i <= 3) {

			item[i].setPosition(900 * 5/8 , 160*(i+1) );
		}
		else if (i <= 7) {
			item[i].setPosition(900 * 6 / 8, 160 * (i -3));
		}
		else {
			item[i].setPosition(900 * 7/8, 160*(i-7));
		}

		if (col == 0) {
			item[i].setColor(Color::Red);
		}
		else if (col == 1) {
			item[i].setColor(Color::Blue);
		}
		else if (col == 2) {
			item[i].setColor(Color::Green);
		}
		else {
			item[i].setColor(Color::Yellow);
		}
	}
	//빨강 - 포탄+1, 파랑 - 포탄-1, 초록 - 레이저, 노랑 - 일반 점수



	Item bullet{ 0,0,0,Color::Black };
	//포탄을 생성자로 초기화(처음 켰을때 안보이게)

	int defaultBullet = 5;
	int bulletCount = defaultBullet;
	bool isFired = false;

	Text text;
	Text ammoText; //남은 포탄 개수 표시할 텍스트

	Font font;


	int t = 0;

	if (!font.loadFromFile("C:\\arial.ttf")) { //E:\\works\\practice\\ch7\\x64\\Debug
		return 42; // Robust error handling!
	}

	/*
	폰트 파일 경로 꼭 수정할 것
	*/

	text.setFont(font);
	ammoText.setFont(font);

	text.setString(to_string(t) + " sec");
	ammoText.setString(to_string(bulletCount) + "left");

	text.setCharacterSize(20);
	ammoText.setCharacterSize(20);

	text.setFillColor(Color::Blue);
	ammoText.setFillColor(Color::White);

	text.setPosition(0, 0);
	ammoText.setPosition(0, 20);

	clock_t time = clock();


	// 여기서부터 게임 루프
	while (window.isOpen())
	{


		// 이벤트 검사 및 처리
		Event e;

		while (window.pollEvent(e)) {

			if (e.type == Event::Closed)

				window.close();

		}

		if (Keyboard::isKeyPressed(Keyboard::Up)) {

			//cout << "up" << endl;

			myrect.rect.rotate(-1);
			currentangle = 270 - myrect.rect.getRotation(); //각도 업데이트


		}

		else if (Keyboard::isKeyPressed(Keyboard::Down)) {

			//cout << "down" << endl;


			myrect.rect.rotate(+1);
			currentangle = 270 - myrect.rect.getRotation(); //각도 업데이트


		}

		if (Keyboard::isKeyPressed(Keyboard::Space)) {
			//누르고 있는 동안 power 점차 증가
			Sleep(10);

			//최대 파워
			if (power < maxPower) {
				power += 0.1;
				cout << fixed << setprecision(1) << "power: " << power << endl; //소수점 첫째자리까지 출력
			}
			else {
				cout << "max power" << endl;
			}
		}
		else {
			power = defaultPower; //스페이스바 눌렀다 떼면 power 초기화
		}


		if (Keyboard::isKeyPressed(Keyboard::Space) && Keyboard::isKeyPressed(Keyboard::F)) {
			// f랑 스페이스바 동시에 누르면 발사
			Sleep(500);

			//포탄 개수 여부에 따라 발사
			if (bulletCount) {
				isFired = true;

				//대포 위치에 따른 포탄 위치 초기화 (수업시간에 배웠던 -> 사용)
				bullet.getCircleShape()->setRadius(width / 2);
				bullet.getCircleShape()->setPosition(myrect.rect.getPosition().x + cos(currentangle * 3.14 / 180) * height - sin(currentangle * 3.14 / 180) * width,
					myrect.rect.getPosition().y - sin(currentangle * 3.14 / 180) * height - cos(currentangle * 3.14 / 180) * width);
				bullet.getCircleShape()->setFillColor(Color::White);

				//업데이트됐던 각도에 따라 vx,vy 초기화
				vx = power * cos(currentangle * 3.14 / 180);
				vy = -power * sin(currentangle * 3.14 / 180);
				bulletCount -= 1;
				cout << bulletCount << " ammo left" << endl;
			}
			else {
				cout << "No Ammo" << endl;
			}
		}

		if (isFired) {

			Sleep(10); //100프레임으로 움직임
			vy += 0.1;

			bullet.getCircleShape()->move(vx, vy);

			if (myrect.rect.getPosition().y > window.getSize().y) {
				isFired = false;
				power = defaultPower;
				myrect.rect.setPosition(width, (double)nY);
			}
		}

		time = clock();

		time = time / CLOCKS_PER_SEC;
		text.setString(to_string(time) + " sec");

		//남은 포탄 표시
		if (bulletCount) {
			ammoText.setString(to_string(bulletCount) + " ammo left");
		}
		else {
			ammoText.setString("No ammo");
		}



		// 화면을 지운다. 
		window.clear();


		window.draw(*bullet.getCircleShape()); //*를 써서 역참조



		window.draw(myrect.rect);

		window.draw(text);
		window.draw(ammoText);

		for (int i = 0; i < 12; i++) {
			window.draw(*item[i].getCircleShape());
		}






		// 화면을 표시한다. 

		window.display();

	}

	return 0;
}
