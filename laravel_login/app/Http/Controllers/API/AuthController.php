<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Requests\Auth\LoginRequest;
use App\Providers\RouteServiceProvider;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\View\View;
use App\Models\User;
use App\Models\Gategore;
use Illuminate\Auth\Events\Registered;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rules;



class AuthController extends Controller
{
    public function login(LoginRequest $request)
    {
        $request->authenticate();

        if($request->wantsJson()){
            $request->user()->tokens()->delete();

            $token=$request->user()->createToken('register_token')->plainTextToken;
            return response()->json([
                'token'=>$token,
                'message'=> __('Success'),
            ],200);
        }

        $request->session()->regenerate();

        return redirect()->intended(RouteServiceProvider::HOME);
    }

    public function register(Request $request,User $user)
    {
        $request->validate([
            'name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'string', 'email', 'max:255', 'unique:'.User::class],
            'password' => ['required', 'confirmed', Rules\Password::defaults()],
        ]);

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
        ]);

        event(new Registered($user));

        Auth::login($user);
        if($request->wantsJson()){
            $token=$user->createToken('register_token');
            return response()->json([
                'token'=>$token->plainTextToken,
                'message'=>__('successfully')
            ],200);
        }
        return redirect(RouteServiceProvider::HOME);
    }

    public function getUserInfo()
{
    $user = Auth::user();

    if (!$user) {
        return response()->json(['message' => 'User not authenticated'], 401);
    }

    return response()->json([
        'user' => $user,
        'message' => 'User information retrieved successfully',
    ], 200);
}

    public function getGategoreData()
    {
        $data = Gategore::all();

        return response()->json(['data' => $data], 200);
    }

}
